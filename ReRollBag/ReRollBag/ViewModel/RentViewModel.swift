//
//  RnetViewModel.swift
//  ReRollBag
//
//  Created by MacBook on 2023/06/03.
//

import Foundation

class RentViewModel: ObservableObject {
    @Published var bagsId: String = ""
    @Published var rentState: Bool = false
    @Published var bags: [BagInfo] = []
    
    func updateRentingStatus(usersId: String){
        BagsManager().updateRentingStatus(usersId: usersId, bagsId: bagsId) { result in
            switch result {
            case .success(let state) :
                DispatchQueue.main.async {
                    print("성공 \(state)")
                    self.rentState = state
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
}
