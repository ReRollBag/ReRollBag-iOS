//
//  GoogleMap.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI
import GoogleMaps

typealias LatLng = (Double, Double)

struct GoogleMapView : UIViewRepresentable {
    private let zoom: Float = 16.0
    @Binding var cameraPosition: GMSCameraPosition
    
 // MARK: - Map을 그리고 생성하는 메서드
       func makeUIView(context: Self.Context) -> GMSMapView {
           context.coordinator.getGoogleMapView()
       }
    
    // MARK: - Map이 업데이트 될 때 발생하는 메서드
       func updateUIView(_ mapView: GMSMapView, context: Context) {
           context.coordinator.view.animate(to: cameraPosition)
       }
    // MARK: - makeCoordinator
    func makeCoordinator() -> GoogleMapCoordinator {
        GoogleMapCoordinator.shared
    }
    
}

// MARK: - Coordinator
final class GoogleMapCoordinator: NSObject, ObservableObject, CLLocationManagerDelegate, GMSMapViewDelegate {
    static let shared = GoogleMapCoordinator()
    let view = GMSMapView(frame: .zero)
    var currentAddress: String = ""
    var markers: [GMSMarker] = []
    var locationManager: CLLocationManager?
    var zoom: Float = 16.0
    
    @Published var coord: (Double, Double) = (0.0, 0.0) //카메라 위치
    @Published var userLocation: (Double, Double) = (0.0, 0.0)// 유저 위치
    @Published var isMarkerTapped: Bool = false
    @Published var selectedMarker: GMSMarker? = nil
    @Published var selectedRentMarkerInfo: RentingMarker? = nil
    @Published var selectedReturnMarkerInfo: ReturningMarker? = nil
    @Published var mapState: Bool = false // false: renting,true: returning
    var bagVM: BagViewModel = BagViewModel()
    
    override init() {
        super.init()
        view.delegate = self
        view.setMinZoom(12, maxZoom: 18)
        view.settings.myLocationButton = false
        view.settings.compassButton = false
        view.animate(to: GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: zoom))
        view.isIndoorEnabled = false
        checkIfLocationServicesIsEnabled()
        makeRentingMarkers()
    }
    
    deinit {
        print("Coordinator deinit!")
    }
    
    
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.checkLocationAuthorization()
                }
            } else {
                print("Show an alert letting them know this is off and to go turn i on.")
            }
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into setting to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Success")
            coord = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("LocationManager-coord: \(coord)")
            userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("LocationManager-userLocation: \(userLocation)")
            fetchUserLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func getGoogleMapView() -> GMSMapView {
        view
    }
  
    func fetchUserLocation() {
        if let locationManager = locationManager {
            let lat = locationManager.location?.coordinate.latitude
            let lng = locationManager.location?.coordinate.longitude
            view.animate(to: GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lng ?? 0.0), zoom: zoom))
            dump(#function)
        }
    }
    // MARK: - 대여 가방 마커들을 그리는 메소드
    func makeRentingMarkers() {
        for marker in bagVM.rentingMarkers{
            let coord = CLLocationCoordinate2D(latitude: marker.latitude, longitude: marker.longitude)
            let gmsMarker = GMSMarker(position: coord)
            gmsMarker.icon = UIImage(named: "rentMarker")
            gmsMarker.userData = marker
            gmsMarker.map = view
            markers.append(gmsMarker)
        }
    }
    
    // MARK: - 반납 가방 마커들을 그리는 메소드
    func makeReturningMarkers() {
        for marker in bagVM.returningMarkers{
            let coord = CLLocationCoordinate2D(latitude: marker.latitude, longitude: marker.longitude)
            let gmsMarker = GMSMarker(position: coord)
            gmsMarker.icon = UIImage(named: "returnMarker")
            gmsMarker.map = view
            markers.append(gmsMarker)
        }
    }
    
    // MARK: - 모든 마커를 삭제하는 메소드
    func removeMarkers() {
        for marker in markers {
            marker.map = nil
        }
        markers = []
    }
    
    // MARK: - 반납/대여 버튼 토글
    func mapStateToggle() {
        removeMarkers()
        mapState.toggle()
        if mapState {
            bagVM.findAllReturningMarkers{
                self.makeReturningMarkers()
            }
        }else{
            bagVM.findAllRentingMarkers{
                self.makeRentingMarkers()
            }
        }
    }
    
    func getRentMarkerInfo()-> RentingMarker {
        return selectedMarker!.userData as! RentingMarker
    }
    
    func getReturnMarkerInfo()-> ReturningMarker {
        return selectedMarker!.userData as! ReturningMarker
    }
    
    func animateToCameraPosition(_ cameraPosition: GMSCameraPosition) {
            view.animate(to: cameraPosition)
    }
    
    // MARK: - 카메라 이동
    func moveCameraPosition() {
        let cameraPosition = GMSCameraPosition.camera(withLatitude: coord.0, longitude: coord.1, zoom: zoom)
        view.animate(to: cameraPosition)
    }
    func moveCameraPositionWithPosition(_ position: CLLocationCoordinate2D) {
        view.animate(to: GMSCameraPosition.camera(withTarget: position, zoom: zoom))
    }
    
    // MARK: - 카메라의 움직임이 완전히 끝나면 호출되는 콜백 메서드
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let target = mapView.camera.target
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        zoom = position.zoom
    }
    
    // MARK: - 지도 터치에 이용되는 Delegate, 마커가 탭되지 않은 경우에만 특정 좌표의 탭 동작 이후에 호출됩니다.
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Map Tapped")
        if let selectedMarker = selectedMarker {
            selectedMarker.icon = UIImage(named: mapState ? "returnMarker" : "rentMarker")
            self.selectedMarker = nil // Reset selectedMarker to nil after changing its icon
        }
        isMarkerTapped = false
    }
    
    // MARK: - 마커를 탭한 후에 호출됩니다.
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("marker tapped")
        if let selectedMarker = selectedMarker {
            selectedMarker.icon = UIImage(named: mapState ? "returnMarker" : "rentMarker") // Change the previously selected marker's icon back to normal
        }
        selectedMarker = marker // Assign the new selected marker
        selectedMarker?.icon = UIImage(named: mapState ? "returnMarkerTapped" : "rentMarkerTapped") // Change the newly selected marker's icon
        moveCameraPositionWithPosition(marker.position) // 선택한 마커로 이동
        isMarkerTapped = true
        return true
    }
    
    
}
 
