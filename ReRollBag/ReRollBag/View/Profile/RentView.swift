//
//  RentView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/06/04.
//

import SwiftUI

struct RentView: View {
    @State var tabSelection : Int = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            BagCategoryView(tabSelection: $tabSelection).frame(height: 30)
                .padding(5)
            RentListTabView(tabSelection: $tabSelection)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("대여목록")
                    .foregroundColor(Color("Green1"))
                    .font(.headline)
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("Green1"))
                }
            }
        }
        
    }
}

struct RentView_Previews: PreviewProvider {
    static var previews: some View {
        RentView()
    }
}
