//
//  ProfileView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI

struct Bag: Identifiable,Hashable {
    var id: UUID = UUID()
    var code: String
    var start: String
    var end: String
    var region: String
    var state: String // 대여중,반납
    
    init(code: String, start: String, end: String, region: String,state: String) {
        self.id = UUID()
        self.code = code
        self.start = start
        self.end = end
        self.region = region
        self.state = state
    }
}

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss // iOS15>=
    @State private var isOnNotification : Bool = false
    @State var bags: [Bag] = []
    //대여기간(시작일, 종료일) 대여장소 코드
    var body: some View {
        
        List {
            Section {
                HStack{
                    Circle()
                        .frame(height: 70)
                        .foregroundColor(Color("Green2"))
                    VStack(alignment: .leading){
                        HStack(alignment: .bottom){
                            Text("홍길동")
                                .font(.title)
                                .bold()
                            Text("지구방위대원")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "gearshape")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.bottom,2)
                        Text("21번째 비닐 격퇴 성공!")
                            .foregroundColor(Color("Ivory3"))
                    }
                }
            }
            
            
            Section {
                NavigationLink(destination: EmptyView()) {
                    Text("대여목록")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("공지사항")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("관리자 신청")
                }
            } header: {
                Text("기능")
            }
            
            Section {
                Toggle(isOn: $isOnNotification) {
                    Text("알림 설정")
                }
                
                NavigationLink(destination: EmptyView()) {
                    Text("이용약관")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("개인정보 처리방침")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("로그아웃")
                }
            } header: {
                Text("어플리케이션 설정")
            }
            
            Section {
                if bags.isEmpty {
                    HStack{
                        Spacer()
                        Text("대여중인 가방이 없습니다")
                            .bold()
                            .frame(height:Screen.maxHeight*0.15,alignment:.center)
                        Spacer()
                    }
                }else{
                    ForEach(bags, id: \.self) { bag in
                        HStack{
                            Circle()
                                .frame(height:50)
                                .foregroundColor(Color("Green1"))
                            VStack(alignment: .leading){
                                Text("\(bag.code)")
                                    .bold()
                                HStack{
                                    Text("대여기간 ")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                    Text("\(bag.start) ~ \(bag.end)")
                                }
                                HStack{
                                    Text("대여장소 ")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                    Text(" \(bag.region)")
                                }
                                
                            }
                        }
                    }
                }
            } header: {
                HStack{
                    Text("대여 중인 가방")
                    Spacer()
                    Button(action: {
                        //대여중인 가방 리디렉트 메소드
                        
                        //임시 테스트용 메소드
                        bags.append(Bag(code: "AC2878", start: "01.27", end: "02.01", region: "GS편의점 우만점",state: "대여중"))
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                }
            }


        }
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("ReRollBag")
                    .foregroundColor(Color("Green1"))
                    .font(.title3)
                    .bold()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("Green1"))
                        .font(.title3)
                        .bold()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView()
        }
    }
}
