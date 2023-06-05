//
//  MapView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI
import GoogleMaps

struct MapView: View {
    @StateObject var coordinator = GoogleMapCoordinator.shared
    @StateObject var rentVM = RentViewModel()
    
    @State private var cameraPosition = GMSCameraPosition.camera(withLatitude: 37.280269 , longitude: 127.043668, zoom: 23.0)
    
    var body: some View {
        ZStack{
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
                            coordinator.checkIfLocationServicesIsEnabled()
                        }) {
                            Circle()
                                .foregroundColor(.white)
                                .frame(height: 40)
                                .shadow(radius: 5)
                                .overlay{
                                    Image(systemName: "location")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height:18)
                                        .foregroundColor(.black)
                                }
                        }
                        Spacer()
                    }
                    .padding([.leading,.trailing],20)
                    HStack{
                        // 빌리기/반납 마커 바꾸기
                        //현재 그리고 있는 마커 삭제 -> 상태에 해당하는 마커 불러오기 -> 마커 그리기
                        Button(action: {
                            // 마커 교체 메소드
                            coordinator.mapStateToggle()
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
                    .padding([.leading,.trailing],20)
                    .padding(.bottom,coordinator.isMarkerTapped ? 10 : 120)
                    
                    if coordinator.isMarkerTapped {
                        //대여 마커
                        if coordinator.mapState == false {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: Screen.maxHeight*0.3)
                                .foregroundColor(.white)
                                .overlay {
                                    VStack{
                                        HStack{
                                            Image("bag")
                                                .frame(height:70)
                                            VStack(alignment: .leading){
                                                Text("\(coordinator.getRentMarkerInfo().name)")
                                                    .font(.headline)
                                                Text("대여 가능한 가방 갯수")
                                                    .font(.footnote)
                                                    .foregroundColor(.secondary)
                                                    .padding(.top,10)
                                                Text("\(coordinator.getRentMarkerInfo().currentBagsNum) / \(coordinator.getRentMarkerInfo().maxBagsNum)개")
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
                        // 반납 마커
                        else {//selectedMarker type 이 returnMarker 일때
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: Screen.maxHeight*0.3)
                                .foregroundColor(.white)
                                .overlay {
                                    VStack{
                                        HStack{
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(.blue)
                                                .overlay{
                                                    Image(systemName: "r.circle")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(height:60)
                                                        .foregroundColor(.white)
                                                }
                                                .frame(width:80, height:80)
                                            VStack(alignment: .leading){
                                                Text("빕스 반대편")
                                                    .font(.headline)
                                                Text("위치가 확인되었습니다.")
                                                    .font(.footnote)
                                                    .foregroundColor(.secondary)
                                                    .padding(.top,10)
                                                Text("반납하려면 QR코드를 촬영해주세요.")
                                                    .font(.footnote)
                                                    .foregroundColor(.secondary)
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
                    
                }
                .ignoresSafeArea(.all,edges: .bottom)
                .zIndex(1)
                VStack{
                    Spacer()
                    NavigationLink(destination: ScannerView(rentVM: rentVM)) {
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
                    .padding(.bottom,15)
                    .padding(.horizontal,20)
                }
                .zIndex(2)
                GoogleMapView(cameraPosition: $cameraPosition)
                    .ignoresSafeArea(.all,edges: .bottom)
            }//ZStack
            .navigationBarTitleDisplayMode(.inline)
            .onAppear{
                if !coordinator.mapState{
                    coordinator.bagVM.findAllRentingMarkers()
                }else{
                    coordinator.bagVM.findAllReturningMarkers()
                }
            }
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
                    }//NavigationLink
                }//ToolbarItem
            }//toolbar
            if rentVM.rentState {
                Color.black.opacity(0.2)
                if !coordinator.mapState{
                    RentAlertView(rentVM: rentVM)
                }else{
                    ReturnAlertView(rentVM: rentVM)
                }
            }
            
        }//ZStack
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MapView()
        }
    }
}
