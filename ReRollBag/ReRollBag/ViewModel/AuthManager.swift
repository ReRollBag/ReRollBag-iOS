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
    
    let root = "http://34.64.247.152:8080"
    
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
            
            do{
                let data = try JSONDecoder().decode(Bool.self, from: data)
                //print(isDuplicated)
                //completion(.success(isDuplicated))
            }catch{
                print("decode error")
                return
            }
        }.resume()
        
    }
    
    
}
