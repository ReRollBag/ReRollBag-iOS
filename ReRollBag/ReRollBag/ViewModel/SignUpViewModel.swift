//
//  UserViewModel.swift
//  ReRollBag
//
//  Created by MacBook on 2023/02/28.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var pw: String = ""
    @Published var checkPw: String = ""
    @Published var name: String = ""
    
    @Published var isDuplicated = false
    
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
    
}
