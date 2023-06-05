//
//  RentedBag.swift
//  ReRollBag
//
//  Created by MacBook on 2023/06/04.
//

import Foundation

struct RentedBag : Codable {
    var bagsId: String
    var whenIsRented: String //"2023-05-26T00:11:25.426"
    var whenIsReturned: String
}
