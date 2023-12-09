//
//  LoginVM.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import Foundation

class LoginVM {

    func login(email: String, password: String, completion: @escaping (Result<String, APIError>) -> Void) {
        APIManager.shared.login(email: email, password: password, completion: completion)
    }
}
