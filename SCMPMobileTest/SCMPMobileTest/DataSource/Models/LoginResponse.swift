//
//  LoginResponse.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import Foundation

struct LoginResponse: Codable, Hashable {
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
