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
    //@Binding var cameraPosition: LatLng
    //@Binding var currentIndex: Int
    private let zoom: Float = 15.0
    
 // MARK: - Map을 그리고 생성하는 메서드
       func makeUIView(context: Self.Context) -> GMSMapView {
           let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
           let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
           return mapView
       }
    
    // MARK: - Map이 업데이트 될 때 발생하는 메서드
       func updateUIView(_ mapView: GMSMapView, context: Context) {
           
       }
    // MARK: - makeCoordinator
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
}

// MARK: - Coordinator
final class Coordinator: NSObject, ObservableObject {
    static let shared = Coordinator()
    
}

//final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
//    var mapViewControllerBridge: MapViewControllerBridge
//
//    init(_ mapViewControllerBridge: MapViewControllerBridge) {
//      self.mapViewControllerBridge = mapViewControllerBridge
//    }
//  }
 
