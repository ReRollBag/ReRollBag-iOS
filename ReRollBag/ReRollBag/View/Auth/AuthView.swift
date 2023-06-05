//
//  AuthView.swift
//  ReRollBag
//
//  Created by MacBook on 2023/03/02.
//

import SwiftUI

enum AuthState {
    case signIn(_ a: Bool)
    case signUp
    case launchScreen
}

struct AuthView: View {
    @State private var authState : AuthState = .launchScreen
    var body: some View {
        switch authState {
        case .launchScreen :
            ZStack(alignment: .center) {
                Color.white.edgesIgnoringSafeArea(.all).zIndex(0)
                Text("ReRollBag")
                    .foregroundColor(Color("Green2"))
                    .font(.abhayaLibreLargeTitle)
                    .bold()
                    .zIndex(1)
                    .onAppear {
                        // 특정 코드를 일정 시간 뒤에 실행시키고자 하는 경우!
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                            withAnimation {
                                authState = .signIn(true)
                            }
                        })
                    }
            }
        case .signIn(let isLoginFailed):
            SignInView(authState: $authState,isLoginFailed: isLoginFailed)
        case .signUp:
            SignUpView(authState: $authState)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
