//
//  SignInView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI

struct SignInView: View {
    
    @Binding var authState : AuthState
    
    @State private var isLoggedIn : Bool = false
    
    @State private var id : String = ""
    @State private var pw : String = ""
    @State private var isShowingPw : Bool = false
    @State private var isSignInButtonDisabled : Bool = true
    
    var isLoginFailed : Bool
    
    var body: some View {
        VStack{
            Text("ReRollBag")
                .foregroundColor(Color("Green2"))
                .font(.abhayaLibreLargeTitle)
                .bold()
                .padding([.top,.bottom],Screen.maxHeight*0.07)
            
            Spacer()
            
            Group{
                TextField("아이디", text: $id)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                Divider()
            }
            
            Group{
                if isShowingPw {
                    TextField("비밀번호", text: $pw)
                        .textFieldStyle(.plain)
                        .frame(maxWidth: .infinity)
                        .padding(.top,20)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .overlay {
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        isShowingPw.toggle()
                                    }) {
                                        Image(systemName: isShowingPw ? "eye.slash": "eye")
                                    }
                                    .foregroundColor(Color("Gray2"))
                                }
                            }
                        }
                }else{
                    SecureField("비밀번호", text: $pw)
                        .textFieldStyle(.plain)
                        .frame(maxWidth: .infinity)
                        .padding(.top,20)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .overlay {
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        isShowingPw.toggle()
                                    }) {
                                        Image(systemName: isShowingPw ? "eye.slash": "eye")
                                    }
                                    .foregroundColor(Color("Gray2"))
                                }
                            }
                        }
                }
                
                Divider()
                VStack{
                    if !isLoginFailed {
                        HStack{
                            Text("아이디 또는 비빌번호가 일치하지 않습니다.")
                                .font(.footnote)
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }.frame(height: 10)
            }
            
            NavigationLink(destination: ContentView(), isActive: $isLoggedIn) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 55)
                    .foregroundColor(Color("Green1"))
                    .overlay {
                        Text("로그인")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
            }
            .buttonStyle(.plain)
            .padding(.top,20)
            
            Button(action: {
                withAnimation(.easeInOut)  {
                    authState = .signUp
                }
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("Green1"), lineWidth: 1)
                    .frame(height: 55)
                
                    .overlay {
                        Text("회원가입")
                            .font(.title3)
                            .foregroundColor(Color("Green1"))
                    }
            }
            
            .buttonStyle(.plain)
            .padding(.top,12)
            
            Text("SNS 계정으로 로그인")
                .font(.footnote)
                .padding(.top,40)
            HStack(spacing: 40){
                VStack{
                    Button(action: {
                        
                    }) {
                        Image("naver")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                    }
                    Text("네이버 로그인")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                VStack{
                    Button(action: {
                        
                    }) {
                        Image("kakao")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                    }
                    Text("카카오 로그인")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                VStack{
                    Button(action: {
                        
                    }) {
                        Image("google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                    }
                    Text("구글 로그인")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .ignoresSafeArea(.all,edges: [.bottom])
        }
        .padding(30)
        
        
    }
}

struct SignInView_Previews: PreviewProvider {
    @State static var authState : AuthState = .signIn(true)
    static var isLoginFailed: Bool = true
    static var previews: some View {
        NavigationView{
            SignInView(authState: $authState, isLoginFailed: isLoginFailed)
        }
    }
}
