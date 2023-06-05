//
//  RentSuccessView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/31.
//

import SwiftUI

struct RentSuccessView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var rentVM: RentViewModel
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    VStack(alignment: .leading,spacing: 5){
                        Text("대여가 완료되었습니다!")
                            .font(.title3)
                            .bold()
                            .padding(.top,30)
                        Text("회원님 덕분에 지구가 꺠끗해지고 있어요!")
                    }
                    Spacer()
                }
                //                Text("\(21)번째 비닐 결퇴 성공")
                //                    .foregroundColor(Color("Ivory3"))
                //                    .font(.title3)
                //                    .bold()
                //                    .padding(.top,80)
            }
            .padding(30)
            ZStack{
                Image("complete2")
                    .resizable()
                    .frame(width: Screen.maxWidth*0.9)
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom,80)
                VStack{
                    Spacer()
                    Button(action: {
                        rentVM.rentState = false
                        dismiss()
                    }) {
                        Rectangle().fill(Color("Green1"))
                            .frame(width: Screen.maxWidth,height: 80)
                            .overlay {
                                Text("지구 지키러 가기")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                    }
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .ignoresSafeArea(.all,edges: .bottom)
        .navigationBarBackButtonHidden()
    }
}

//struct RentSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        RentSuccessView()
//    }
//}
