//
//  BagCategoryView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/06/04.
//

import SwiftUI

struct BagCategoryView: View {
    let categories : [String] = ["전체","반납","대여"]
        
        let rows = [
            GridItem(.fixed(40))
        ]
        
        @Binding var tabSelection : Int
        var body: some View {
            ScrollView(.horizontal){
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(categories.indices, id: \.self) { index in
                        Button(action: {
                            tabSelection = index
                        }) {
                            RoundedRectangle(cornerRadius: .infinity)
                                .foregroundColor(tabSelection == index ? Color("Green1") : Color("Gray1")).overlay {
                                    Text(categories[index])
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                .frame(width: 60)
                        }
                    }
                }
            }
            .padding()
            //스크롤상태바 삭제
            .scrollIndicators(.hidden)
        }
}

//struct BagCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        BagCategoryView()
//    }
//}
