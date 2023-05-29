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
}

struct AuthView: View {
    @State private var authState : AuthState = .signIn(true)
    
    var body: some View {
        switch authState {
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
