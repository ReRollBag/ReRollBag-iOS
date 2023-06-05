//
//  UserToken.swift
//  ReRollBag
//
//  Created by MacBook on 2023/05/30.
//

import Foundation

struct UserToken: Codable {
    var accessToken: String
    var refreshToken: String
}
