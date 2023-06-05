//
//  UserViewModel.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var pw: String = ""
    @Published var checkPw: String = ""
    @Published var name: String = ""
    
    @Published var isDuplicated = false
    @Published var errorMessage: String = ""
    @Published var firebaseToken: String = ""
    @Published var isCompletedSignUp: Bool = false
    
    
    // MARK: - 회원가입시 이메일 중복체크 메소드
    func checkEmailDuplicated() {
        AuthManager().checkEmailDuplicated(email) { result in
            switch result {
            case .success(let check) :
                DispatchQueue.main.async {
                    print("성공 \(check)")
                    self.isDuplicated = check
                }
            case .failure(let error) :
                print("Network Error : \(error)")
            }
        }
    }
    
    // MARK: - 파이어베이스 등록 및 파이어베이스 토큰 발급
    func signUpWithEmailPassword(_ completion: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: pw){ authDataResult,error in
            if let error = error {
                print("Failed to sign up: \(error.localizedDescription)")
                return
            }
            
            if let currentUser = Auth.auth().currentUser {
                currentUser.getIDToken { token, error in
                    if let error = error {
                        // 토큰 가져오기 실패
                        print("Failed to get user token: \(error.localizedDescription)")
                        return
                    }
                    
                    if let token = token {
                        // 토큰 가져오기 성공
                        print("User token: \(token)")
                        self.firebaseToken = token
                        self.isCompletedSignUp = true
                    }
                    
                    AuthManager().userSave(self.email, name: self.name, idToken: self.firebaseToken, userRole: "ROLE_USER") { result in
                        switch result {
                        case .success(let token) :
                            DispatchQueue.main.async {
                                UserViewModel.shared.token = token
                                //Task: UserDefaults에 토큰저장
                                print("accessToken: \(token.accessToken)")
                                print("refreshToken: \(token.refreshToken)")
                            }
                        case .failure(let error):
                            print("Network Error : \(error)")
                        }
                    }
                    
                    
                }
            } else {
                // 현재 로그인한 사용자 없음
                print("No logged-in user.")
            }
        }
        return
    }
    
    // MARK: - 서버에 회원가입한 유저정보 등록 및 토큰 발급
    func signUpCompleteWithUserSave() -> Void {
        signUpWithEmailPassword { [self] in
            AuthManager().userSave(email, name: name, idToken: firebaseToken, userRole: "ROLE_USER") { result in
                switch result {
                case .success(let token) :
                    DispatchQueue.main.async {
                        UserViewModel.shared.token = token
                        //Task: UserDefaults에 토큰저장
                        print("accessToken: \(token.accessToken)")
                        print("refreshToken: \(token.refreshToken)")
                    }
                case .failure(let error):
                    print("Network Error : \(error)")
                }
            }
        }
    }
    
    // 파이어베이스 로그인 메소드
    func signIn(email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            print("Sign in successful: \(authResult.user.uid)")
            
            if let currentUser = Auth.auth().currentUser {
                currentUser.getIDToken { token, error in
                    if let error = error {
                        // 토큰 가져오기 실패
                        print("Failed to get user token: \(error.localizedDescription)")
                        return
                    }
                    
                    if let token = token {
                        // 토큰 가져오기 성공
                        print("User token: \(token)")
                    }
                }
            }
        } catch {
            throw error
        }
    }
    
}
