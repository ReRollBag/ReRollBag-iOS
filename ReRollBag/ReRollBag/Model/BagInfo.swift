//
//  BagInfo.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/31.
//

import Foundation

struct BagInfo : Codable,Hashable {
    var bagsId: String
    var whenIsRented: String
    var rentingUserId: String?
    var rented: Bool?
    var whenIsReturned: String?
    var isReturning: Bool?
    
    var shortRentedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        if let date = dateFormatter.date(from: whenIsRented) {
            let shortDateFormatter = DateFormatter()
            shortDateFormatter.dateFormat = "MM.dd"
            return shortDateFormatter.string(from: date)
        }
        
        return ""
    }
    
    var shortReturnedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        guard let whenIsReturned = self.whenIsReturned else{
            return ""
        }
        
        if let date = dateFormatter.date(from: whenIsReturned) {
            let shortDateFormatter = DateFormatter()
            shortDateFormatter.dateFormat = "MM.dd"
            return shortDateFormatter.string(from: date)
        }
        
        return""
    }
}
