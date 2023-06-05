//
//  UserViewModel.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/30.
//

import Foundation

class UserViewModel : ObservableObject {
    static var shared = UserViewModel()
    
    @Published var token: UserToken = UserToken(accessToken: "", refreshToken: "")
    @Published var user: User = User(userId: "", userName: "")
    
    // 토큰을 저장할 UserDefaults 키
    let refreshTokenKey = "refreshToken"
    let accessTokenKey = "accessToken"

    // 토큰을 UserDefaults에 저장하는 함수
    func saveTokenToUserDefaults(_ token: UserToken) {
        UserDefaults.standard.set(token.accessToken, forKey: accessTokenKey)
        UserDefaults.standard.set(token.refreshToken, forKey: refreshTokenKey)
    }

    // UserDefaults에서 토큰을 가져오는 함수
    func getTokenFromUserDefaults() -> UserToken? {
        let accessToken = UserDefaults.standard.string(forKey: accessTokenKey)
        let refreshToken = UserDefaults.standard.string(forKey: refreshTokenKey)
        
        if let accessToken, let refreshToken {
            return UserToken(accessToken: accessToken, refreshToken: refreshToken)
        }
        return nil
    }

    // 토큰을 삭제하는 함수
    func removeTokenFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
        UserDefaults.standard.removeObject(forKey: accessTokenKey)
    }
    
}
