//
//  ReturningBag.swift
//  ReRollBag
//
//  Created by MacBook on 2023/06/04.
//

import Foundation

struct ReturningBag : Codable {
    var bagsId: String
    var whenIsRented: String
    var rentingUsersId: String
    var rented: Bool
}
