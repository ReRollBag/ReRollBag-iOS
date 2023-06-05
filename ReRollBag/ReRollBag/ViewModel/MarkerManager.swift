//
//  MarkerManager.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/31.
//

import Foundation

class MarkerManager {
    let root = "http://34.64.122.161:8080"
    
    
    func findAllRentingMarkers(completion : @escaping (Result<[RentingMarker],NetworkError>) -> Void){
        guard let url = URL(string: "\(root)/api/v1/markers/renting/findAll") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
                let decodedData = try JSONDecoder().decode([RentingMarker].self, from: data)
                completion(.success(decodedData))
            } catch {
                print("decode error: \(error)")
                completion(.failure(.decodingError))
                return
            }
        }.resume()
        
    }
    
    func findAllReturningMarkers(completion : @escaping (Result<[ReturningMarker],NetworkError>) -> Void){
        guard let url = URL(string: "\(root)/api/v1/markers/returning/findAll") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
                let decodedData = try JSONDecoder().decode([ReturningMarker].self, from: data)
                completion(.success(decodedData))
            } catch {
                print("decode error: \(error)")
                completion(.failure(.decodingError))
                return
            }
        }.resume()
        
    }
    
}
