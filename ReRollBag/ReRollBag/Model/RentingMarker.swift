//
//  RentingMarker.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/31.
//

import Foundation

struct RentingMarker : Codable {
    var latitude: Double
    var longitude: Double
    var name: String
    var maxBagsNum: Int
    var currentBagsNum: Int
    var imageUrl: String
}
