//
//  BorrowListView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/01.
//

import SwiftUI

struct RentListView: View {
    var bags: [BagInfo]
    
    var body: some View {
        ScrollView {
            ForEach(bags,id:\.self) { bag in
                Divider()
                HStack{
                    Image("bag")
                        .frame(height: 70)
                    VStack(alignment: .leading){
                        Text("\(bag.bagsId)")//가방코드
                            .font(.callout)
                            .bold()
                        HStack{
                            Text("대여 기간")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Text("\(bag.shortRentedDate)~\(bag.shortReturnedDate)") // 기간
                                .font(.callout)
                        }
                        HStack{
                            Text("대여 장소")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Text("아주대학교 정문") // 장소 , 수정필요
                                .font(.callout)
                        }
                        
                        
                    }
                    Spacer()
                    if bag.shortReturnedDate != "" {
                        RoundedRectangle(cornerRadius: .infinity)
                            .fill(Color("Gray2"))
                            .frame(width: 60,height: 20)
                            .overlay{
                                Text("반납완료")
                                    .foregroundColor(.white)
                                    .font(.footnote)
                            }
                    }
                }.frame(height: 80)
            }
        }
        .padding()
        .scrollIndicators(.hidden)
        .refreshable {
            Task{
                //
            }
        }
    }
}

//struct RentListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RentListView()
//    }
//}
