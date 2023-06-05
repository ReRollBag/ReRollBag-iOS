//
//  AlertView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/26.
//

import SwiftUI

struct RentAlertView: View {
    @ObservedObject var rentVM: RentViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.white)
            .frame(width: Screen.maxWidth*0.82,height: Screen.maxHeight*0.3)
            .overlay {
                RentAlert()
            }//overlay
    }
    
    var term : String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd"

        var dateRangeString = ""
        if let date = Calendar.current.date(byAdding: .day, value: 0, to: currentDate) {
            let dateString = dateFormatter.string(from: date)
            dateRangeString += dateString
        }
        if let date = Calendar.current.date(byAdding: .day, value: 6, to: currentDate) {
            let dateString = dateFormatter.string(from: date)
            dateRangeString += (dateRangeString.isEmpty ? "" : " ~ ") + dateString
        }
        
        return dateRangeString
    }
    
    @ViewBuilder
    func RentAlert()->some View {
        VStack{
            Text("대여를 확정하시겠습니까?")
                .font(.headline)
                .padding(.bottom,15)
            HStack{
                Image("bag")
                    .frame(height: 50)
                VStack(alignment: .leading){
                    Text("\(rentVM.bagsId)")//가방코드
                        .font(.callout)
                        .bold()
                    HStack{
                        Text("대여 기간")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text("\(term)") // 기간
                            .font(.callout)
                    }
                    HStack{
                        Text("대여 장소")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Text("\("아주대학교 정문")") // 장소
                            .font(.callout)
                    }
                    
                    
                }
            }//HStack
            HStack(spacing: 30){
                NavigationLink(destination: RentSuccessView(rentVM: rentVM)){
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

//struct RentAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack{
//            Color(.black).opacity(0.1)
//            RentAlertView()
//        }
//    }
//}
