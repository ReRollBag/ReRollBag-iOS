//
//  AlertView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/26.
//

import SwiftUI

enum AlertState {
    case borrowBag
    case returnBag
}

struct AlertView: View {
    @State var alertState : AlertState? = nil
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.white)
            .frame(width: Screen.maxWidth*0.82,height: Screen.maxHeight*0.26)
            .overlay {
                if alertState == .borrowBag {
                    BorrowAlert()
                }else if alertState == .returnBag {
                    ReturnAlert()
                }else{
                    Color.white
                }
            }//overlay
    }
    
    @ViewBuilder
    func BorrowAlert()->some View {
        VStack{
            Text("대여를 확정하시겠습니까?")
                .font(.headline)
                .padding(.bottom,15)
            HStack{
                Circle()
                    .frame(height: 50)
                    .padding(.trailing,10)
                VStack(alignment: .leading){
                    Text("\("A1B1C")")//가방코드
                        .font(.callout)
                        .bold()
                    HStack{
                        Text("대여 기간")
                            .font(.footnote)
                        Text("01.31~02.07") // 기간
                            .font(.callout)
                    }
                    HStack{
                        Text("대여 장소")
                            .font(.footnote)
                        Text("GS편의점 우만점") // 장소
                            .font(.callout)
                    }
                    
                    
                }
            }//HStack
            HStack(spacing: 30){
                Button(action: {
                    
                }) {
                    Text("확인")
                        .foregroundColor(.black)
                        .padding(.horizontal,40)
                        .padding(.vertical,10)
                        .background(content: {
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color("Green1"),lineWidth: 1)
                        })
                }
                
                Button(action: {
                    
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
    
    @ViewBuilder
    func ReturnAlert()->some View {
        VStack{
            Text("반납을 확정하시겠습니까?")
                .font(.headline)
                .padding(.bottom,15)
            HStack{
                Circle()
                    .frame(height: 50)
                    .padding(.trailing,10)
                VStack(alignment: .leading){
                    Text("\("A1B1C")")//가방코드
                        .font(.callout)
                        .bold()
                    HStack{
                        Text("대여 기간")
                            .font(.footnote)
                        Text("01.31~02.07") // 기간
                            .font(.callout)
                    }
                    HStack{
                        Text("대여 장소")
                            .font(.footnote)
                        Text("GS편의점 우만점") // 장소
                            .font(.callout)
                    }
                    
                    
                }
            }//HStack
            HStack(spacing: 30){
                Button(action: {
                    
                }) {
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

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color(.black).opacity(0.1)
            AlertView(alertState: .returnBag)
        }
    }
}
