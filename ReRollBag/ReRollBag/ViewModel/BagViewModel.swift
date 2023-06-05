//
//  BagViewModel.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/31.
//

import Foundation
import GoogleMaps

class BagViewModel : ObservableObject {
    @Published var rentingMarkers: [RentingMarker] = []
    @Published var returningMarkers: [ReturningMarker] = []
    @Published var bags: [BagInfo] = []
    
    func findAllRentingMarkers() {
        MarkerManager().findAllRentingMarkers { result in
            switch result {
            case .success(let markers) :
                DispatchQueue.main.async {
                    print("성공 \(markers)")
                    self.rentingMarkers = markers
                    GoogleMapCoordinator.shared.removeMarkers()
                    GoogleMapCoordinator.shared.makeRentingMarkers()
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
    func findAllRentingMarkers(completion: @escaping () -> Void) {
        // 비동기 작업을 수행하는 코드
        // 작업이 완료된 후에 completion()을 호출하여 완료를 알립니다.
        MarkerManager().findAllRentingMarkers { result in
            switch result {
            case .success(let markers) :
                DispatchQueue.main.async {
                    print("성공 \(markers)")
                    self.rentingMarkers = markers
                    GoogleMapCoordinator.shared.removeMarkers()
                    GoogleMapCoordinator.shared.makeRentingMarkers()
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
    func findAllReturningMarkers() {
        MarkerManager().findAllReturningMarkers { result in
            switch result {
            case .success(let markers) :
                DispatchQueue.main.async {
                    print("성공 \(markers)")
                    self.returningMarkers = markers
                    GoogleMapCoordinator.shared.removeMarkers()
                    GoogleMapCoordinator.shared.makeReturningMarkers()
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
    func findAllReturningMarkers(completion: @escaping () -> Void) {
        MarkerManager().findAllReturningMarkers { result in
            switch result {
            case .success(let markers) :
                DispatchQueue.main.async {
                    print("성공 \(markers)")
                    self.returningMarkers = markers
                    GoogleMapCoordinator.shared.removeMarkers()
                    GoogleMapCoordinator.shared.makeReturningMarkers()
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
    
    func getRentingBags() {
        UserManager().getRentingBagList { result in
            switch result {
            case .success(let bags) :
                DispatchQueue.main.async {
                    print("성공 \(bags)")
                    self.bags.append(contentsOf: bags)
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
    func getReturnedBags() {
        UserManager().getReturnedBagsList { result in
            switch result {
            case .success(let bags) :
                DispatchQueue.main.async {
                    print("성공 \(bags)")
                    self.bags.append(contentsOf: bags)
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
    func getReturningBags() {
        UserManager().getReturningBagsList { result in
            switch result {
            case .success(let bags) :
                DispatchQueue.main.async {
                    print("성공 \(bags)")
                    self.bags.append(contentsOf: bags)
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
    func getAllBags(){
        getRentingBags()
        getReturnedBags()
        getReturningBags()
    }
    
    func clearBags() {
        self.bags = []
    }
    
    
}
