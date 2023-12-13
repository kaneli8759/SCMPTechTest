//
//  StaffListResponse.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/10/23.
//

import Foundation

struct StaffListResponse: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [Staff]

    enum CodingKeys: String, CodingKey {
        case page, total, data
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}

struct Staff: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
