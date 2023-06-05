//
//  UserManager.swift
//  ReRollBag
//
//  Created by MacBook on 2023/06/04.
//
import Foundation

class UserManager {
    let root = "http://34.64.122.161:8080"
    
    
    func getRentingBagList(completion : @escaping (Result<[BagInfo],NetworkError>) -> Void){
        guard let url = URL(string: "\(root)/api/v1/users/getRentingBagsList") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ3am0xQVltSENpUENUdmJHOVVoNnI2alJXVGwxIiwianRpIjoidGVzdGR5QHRlc3QuY29tIiwiaWF0IjoxNjg1ODUxNjcxLCJleHAiOjE2ODYwNjc2NzF9.9l-402vZXWYZxM16Q99C3D7FoOxx5xSbqmYE9M9H1T0", forHTTPHeaderField: "token")
        
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
                let decodedData = try JSONDecoder().decode([BagInfo].self, from: data)
                completion(.success(decodedData))
            } catch {
                print("decode error: \(error)")
                completion(.failure(.decodingError))
                return
            }
        }.resume()
        
    }
    
    func getReturnedBagsList(completion : @escaping (Result<[BagInfo],NetworkError>) -> Void){
        guard let url = URL(string: "\(root)/api/v1/users/getReturnedBagsList") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ3am0xQVltSENpUENUdmJHOVVoNnI2alJXVGwxIiwianRpIjoidGVzdGR5QHRlc3QuY29tIiwiaWF0IjoxNjg1ODUxNjcxLCJleHAiOjE2ODYwNjc2NzF9.9l-402vZXWYZxM16Q99C3D7FoOxx5xSbqmYE9M9H1T0", forHTTPHeaderField: "token")
        
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
                let decodedData = try JSONDecoder().decode([BagInfo].self, from: data)
                completion(.success(decodedData))
            } catch {
                print("decode error: \(error)")
                completion(.failure(.decodingError))
                return
            }
        }.resume()
        
    }
    
    func getReturningBagsList(completion : @escaping (Result<[BagInfo],NetworkError>) -> Void){
        guard let url = URL(string: "\(root)/api/v1/users/getReturningBagsList") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ3am0xQVltSENpUENUdmJHOVVoNnI2alJXVGwxIiwianRpIjoidGVzdGR5QHRlc3QuY29tIiwiaWF0IjoxNjg1ODUxNjcxLCJleHAiOjE2ODYwNjc2NzF9.9l-402vZXWYZxM16Q99C3D7FoOxx5xSbqmYE9M9H1T0", forHTTPHeaderField: "token")
        
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
                let decodedData = try JSONDecoder().decode([BagInfo].self, from: data)
                completion(.success(decodedData))
            } catch {
                print("decode error: \(error)")
                completion(.failure(.decodingError))
                return
            }
        }.resume()
        
    }
    
}
