//
//  MapView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack{
            VStack{
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color("Gray2"))
                    .opacity(0.8)
                    .overlay {
                        HStack{
                            Text("지구방위대가 된 걸 환영합니다! 함께 지구를 지켜가요.")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.white)
                    }
            Spacer()
                NavigationLink(destination: EmptyView()) {
                    RoundedRectangle(cornerRadius: 14)
                        .frame(height: 55)
                        .foregroundColor(Color("Green1"))
                        .overlay {
                            Text("로그인")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                }
                .padding(30)
            }
            .zIndex(1)
            GoogleMapView()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ReRollBag")
                    .foregroundColor(Color("Green1"))
                    .font(.title3)
                    .bold()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MapView()
        }
    }
}
