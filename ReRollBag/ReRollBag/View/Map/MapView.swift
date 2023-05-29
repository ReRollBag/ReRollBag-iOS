//
//  MapView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI

struct MapView: View {
    
    @State private var selected: Bool = true // 임시
    
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
                    HStack{
                        //현재위치 버튼
                        Button(action: {
                            //현재위치로 돌아가는 메소드
                        }) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        Spacer()
                    }
                    .padding([.leading,.trailing],30)
                    HStack{
                        // 빌리기/반납 마커 바꾸기
                        Button(action: {
                            // 마커 교체 메소드
                        }) {
                            Circle()
                                .foregroundColor(.blue)
                                .frame(height: 40)
                                .shadow(radius: 5)
                                .overlay {
                                    Image(systemName: "r.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 25)
                                        .foregroundColor(.white)
                                }
                        }
                        Spacer()
                        //새로고침
                        Button(action: {
                            // 리다이렉트 메소드
                        }) {
                            Circle()
                                .foregroundColor(.white)
                                .frame(height: 40)
                                .shadow(radius: 5)
                                .overlay {
                                    Image(systemName: "arrow.clockwise")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 25)
                                        .foregroundColor(.gray)
                                }
                        }
                    }
                    .padding([.leading,.trailing],30)
                    .padding(.bottom,selected ? 10 : 100)
                    
                    if selected {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: Screen.maxHeight*0.28)
                            .foregroundColor(.white)
                            .overlay {
                                VStack{
                                    HStack{
                                        Image(systemName: "plus")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height:70)
                                        VStack(alignment: .leading){
                                            Text("GS편의점 우만점")
                                                .font(.headline)
                                            Text("대여 가능한 가방 갯수")
                                                .font(.footnote)
                                                .foregroundColor(.secondary)
                                                .padding(.top,10)
                                            Text("1 / 5개")
                                                .font(.callout)
                                                .bold()
                                        }
                                        .padding(.leading,30)
                                        Spacer()
                                    }
                                    .padding(30)
                                    Spacer()
                                }
                            }
                    }

                }
                .ignoresSafeArea(.all,edges: .bottom)
                .zIndex(1)
                VStack{
                    Spacer()
                    NavigationLink(destination: QRCodeScannerView()) {
                        RoundedRectangle(cornerRadius: 14)
                            .frame(height: 55)
                            .foregroundColor(Color("Green1"))
                            .overlay {
                                HStack{
                                    Image(systemName: "viewfinder")
                                    Text("QR코드 촬영")
                                }
                                .font(.title3)
                                .foregroundColor(.white)
                            }
                    }
                    .padding([.leading,.trailing],30)
                }
                .zIndex(2)
                GoogleMapView()
                    .ignoresSafeArea(.all,edges: .bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                    Text("ReRollBag")
                        .foregroundColor(Color("Green1"))
                        .font(.title3)
                        .bold()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "list.bullet")
                        .foregroundColor(Color("Green1"))
                        .font(.title3)
                        .bold()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    //테스트용 버튼
                    selected.toggle()
                }) {
                    Circle()
                        .foregroundColor(Color("Green1"))
                        .font(.title3)
                        .bold()
                }
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
