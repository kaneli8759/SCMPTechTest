//
//  APIInfo.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

enum APIInfo {
    case login
    case getStaffList
}

extension APIInfo {
    var baseUrl: String {
        return "https://reqres.in/api"
    }
    
    var path: String {
        switch self {
        case .login:
            return baseUrl + "/login?delay=5"
        case .getStaffList:
            return baseUrl + "users?page="
        }
    }
}
