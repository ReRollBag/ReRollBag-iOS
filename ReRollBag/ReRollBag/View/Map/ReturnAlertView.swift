//
//  ReturnAlertView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/31.
//

import SwiftUI

struct ReturnAlertView: View {
    @ObservedObject var rentVM: RentViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.white)
            .frame(width: Screen.maxWidth*0.82,height: Screen.maxHeight*0.3)
            .overlay {
                ReturnAlert()
            }//overlay
    }
    
    
    @ViewBuilder
    func ReturnAlert()->some View {
        VStack{
            Text("반납을 확정하시겠습니까?")
                .font(.headline)
                .padding(.bottom,15)
            HStack{
                Image("bag")
                    .frame(height: 50)
                VStack(alignment: .leading){
                    Text("\("KOR_SUWON_2")")//가방코드
                        .font(.callout)
                        .bold()
                    HStack{
                        Text("대여 기간")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text("06.04~06.04") // 기간
                            .font(.callout)
                    }
                    HStack{
                        Text("대여 장소")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text("빕스 반대편") // 장소
                            .font(.callout)
                    }
                    
                    
                }
            }//HStack
            HStack(spacing: 30){
                NavigationLink(destination: ReturnSuccessView(rentVM: rentVM)) {
                    Text("확인")
                        .foregroundColor(.white)
                        .padding(.horizontal,40)
                        .padding(.vertical,10)
                        .background(content: {
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color("Green1"))
                        })
                }
                
                Button(action: {
                    rentVM.rentState = false
                }) {
                    Text("취소")
                        .foregroundColor(.black)
                        .padding(.horizontal,40)
                        .padding(.vertical,10)
                        .background(content: {
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color("Green1"),lineWidth: 1)
                        })
                }
                
            }//HStack
            .padding(.top,15)
        }//VStack
        .padding(5)
    }

}

//struct ReturnAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack{
//            Color(.black).opacity(0.1)
//            ReturnAlertView()
//        }
//    }
//}
