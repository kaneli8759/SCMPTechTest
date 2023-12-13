//
//  StaffListVMTests.swift
//  SCMPMobileTestTests
//
//  Created by 李宗政 on 12/10/23.
//

@testable import SCMPMobileTest
import XCTest

final class StaffListVMTests: XCTestCase {
    func testGetStaffListCallsApiManager() {
        let vm = StaffListVM()
        let mockApiManager = MockAPIManager()
        
        vm.getStaffList(pageNumber: "1") { result in
            XCTAssert(mockApiManager.loginCalled)
        }
    }
    
    func testGetListSuccess(){
        let vm = StaffListVM()
        let mockApiManager = MockAPIManager()
        mockApiManager.shouldSuccess = true
        
        vm.getStaffList(pageNumber: "1") { result in
            switch result {
            case .success(let staffList):
                XCTAssertNotNil(staffList)
            case .failure:
                XCTFail("getStaffList should succeed.")
            }
        }
    }
    
    func testGetListFailed() {
        let vm = StaffListVM()
        let mockApiManager = MockAPIManager()
        mockApiManager.shouldSuccess = false
        
        vm.getStaffList(pageNumber: "1") { result in
            switch result {
            case .success:
                XCTFail("getStaffList should fail.")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
