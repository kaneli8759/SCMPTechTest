//
//  LoginVMTests.swift
//  SCMPMobileTestTests
//
//  Created by 李宗政 on 12/10/23.
//

@testable import SCMPMobileTest
import XCTest

final class LoginVMTests: XCTestCase {
    
    func testLoginCallsAPIManager() {
        let vm = LoginVM()
        let mockApiManager = MockAPIManager()
        vm.login(email: "test@mail.com", password: "password") { result in
            XCTAssert(mockApiManager.loginCalled)
        }
    }
    
    func testLoginSuccess() {
        let vm = LoginVM()
        let mockApiManager = MockAPIManager()
        mockApiManager.shouldSuccess = true
        
        vm.login(email: "test@example.com", password: "password") { result in
            switch result {
            case .success(let token):
                XCTAssertNotNil(token)
            case .failure:
                XCTFail("Login should succeed.")
            }
        }
    }
    
    func testLoginFailed() {
        let vm = LoginVM()
        let mockApiManager = MockAPIManager()
        mockApiManager.shouldSuccess = false
        mockApiManager.mockError = .custom("custom error")
        
        vm.login(email: "test@mail.com", password: "password") { result in
            switch result {
            case .success(_):
                XCTFail("Login Should Fail")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
