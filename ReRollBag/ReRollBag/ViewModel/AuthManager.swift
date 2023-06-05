//
//  AuthManager.swift
//  ReRollBag
//
//  Created by MacBook on 2023/03/02.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case noData
    case decodingError
}

class AuthManager {
    
    let root = "http://34.64.122.161:8080"
    
    // MARK: - 서버에 저장된 이메일과 중복됐는지 확인하는 메소드
    func checkEmailDuplicated(_ email : String, completion : @escaping (Result<Bool,NetworkError>) -> Void){
        guard let url = URL(string: "\(root)/api/v2/users/checkUserExist/\(email)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: req) { data, response, error in
            guard let data = data, error == nil else {
                print("No data")
                completion(.failure(.noData))
                return
            }
            
            guard let dataEncoded = String(data: data, encoding: .utf8) else {
                print("encode error")
                return
            }
            
            print("data : \(data)")
            print("dataEncoded: " + dataEncoded)
            
            do {
                let decodedData = try JSONDecoder().decode([String: Bool].self, from: data)
                let isDuplicated = decodedData["data"] ?? false
                completion(.success(isDuplicated))
            } catch {
                print("decode error: \(error)")
                completion(.failure(.decodingError))
                return
            }
        }.resume()
        
    }
    
    // MARK: - 회원가입시 서버에 유저 정보 저장 및 토큰 발급
    func userSave(_ email : String, name: String, idToken: String,userRole: String, completion : @escaping (Result<UserToken,NetworkError>) -> Void) {
        guard let url = URL(string: "\(root)/api/v2/users/save") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
                "usersId": "\(email)",
                "name": "\(name)",
                "idToken": "\(idToken)",
                "userRole": "\(userRole)"
            ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            req.httpBody = jsonData
            
            URLSession.shared.dataTask(with: req) { data, response, error in
                guard let data = data, error == nil else {
                    print("No data")
                    completion(.failure(.noData))
                    return
                }
                
                guard let dataEncoded = String(data: data, encoding: .utf8) else {
                    print("encode error")
                    return
                }
                
                print("data : \(data)")
                print("dataEncoded: " + dataEncoded)
                
                do {
                    let decodedData = try JSONDecoder().decode(UserToken.self, from: data)
                    completion(.success(UserToken(accessToken: decodedData.accessToken, refreshToken: decodedData.refreshToken)))
                } catch {
                    print("decode error: \(error)")
                    completion(.failure(.decodingError))
                    return
                }
            }.resume()
            
        }catch {
            print("Error creating JSON data: \(error)")
        }
        
        
    }
    
    // MARK: - 로그인 및 토큰 갱신
}
