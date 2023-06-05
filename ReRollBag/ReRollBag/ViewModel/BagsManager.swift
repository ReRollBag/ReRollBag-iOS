//
//  BagsManager.swift
//  ReRollBag
//
//  Created by MacBook on 2023/06/03.
//

import Foundation

class BagsManager {
    let root = "http://34.64.122.161:8080"
    
    // MARK: - 서버에 저장된 가방의 대여상태를 변경하고, 대여한 유저의 아이디를 저장하는 메소드
    func updateRentingStatus(usersId: String,bagsId: String, completion : @escaping (Result<Bool,NetworkError>) -> Void){
        guard let url = URL(string: "\(root)/api/v2/bags/renting") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ3am0xQVltSENpUENUdmJHOVVoNnI2alJXVGwxIiwianRpIjoidGVzdGR5QHRlc3QuY29tIiwiaWF0IjoxNjg1ODUxNjcxLCJleHAiOjE2ODYwNjc2NzF9.9l-402vZXWYZxM16Q99C3D7FoOxx5xSbqmYE9M9H1T0", forHTTPHeaderField: "token")
        
        let requestBody: [String: Any] = [
            "usersId": "\(usersId)",
            "bagsId": "\(bagsId)"
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
                    let decodedData = try JSONDecoder().decode([String:Bool].self, from: data)
                    let state = decodedData["data"] ?? false
                    completion(.success(state))
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
    
    
    
}
