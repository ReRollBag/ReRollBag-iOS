//
//  SignInView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import SwiftUI

struct SignInView: View {
    @State private var id : String = ""
    @State private var pw : String = ""
    @State private var isShowingPw : Bool = false
    @State private var isSignInButtonDisabled : Bool = true
    
    var body: some View {
        VStack{
            Text("ReRollBag")
                .foregroundColor(Color("Green1"))
                .font(.largeTitle)
                .bold()
                .padding([.top,.bottom],Screen.maxHeight*0.1)
            
            Group{
                TextField("아이디", text: $id)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                
                Divider()
            }
            
            Group{
                TextField("비밀번호", text: $pw)
                    .textFieldStyle(.plain)
                    .frame(maxWidth: .infinity)
                    .padding(.top,30)
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
                
                Divider()
            }
            NavigationLink(destination: ContentView()) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 55)
                    .foregroundColor(Color("Green1"))
                    .overlay {
                        Text("로그인")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
            }
            .padding(.top,42)
            
            Button(action: {
                
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
            .padding(.top,12)
            
            Text("SNS 계정으로 로그인")
                .font(.footnote)
                .padding(.top,40)
            HStack(spacing: 40){
                Button(action: {
                    
                }) {
                    Circle()
                        .frame(width: 50)
                }
                
                Button(action: {
                    
                }) {
                    Circle()
                        .frame(width: 50)
                }
                
                Button(action: {
                    
                }) {
                    Circle()
                        .frame(width: 50)
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(30)
        
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SignInView()
        }
    }
}
