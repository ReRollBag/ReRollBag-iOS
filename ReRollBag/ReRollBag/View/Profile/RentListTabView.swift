//
//  BorrowListTabView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/01.
//

import SwiftUI

struct RentListTabView: View {
    //["전체","반납","대여중"]
    @Binding var tabSelection : Int
    @StateObject var bagVM: BagViewModel = BagViewModel()
    
    var body: some View {
        VStack{
            TabView(selection: $tabSelection) {
                RentListView(bags: bagVM.bags)
                    .tag(0)
                
                RentListView(bags: bagVM.bags.filter({ bag in
                    if let whenIsReturned = bag.whenIsReturned {
                        return true
                    }
                    return false
                })).tag(1)
                
                RentListView(bags: bagVM.bags.filter({ bag in
                    if let rented = bag.rented {
                        return rented
                    }
                    return false
                })).tag(2)
            }
            .onAppear{
                bagVM.getAllBags()
            }
        }
    }
}
