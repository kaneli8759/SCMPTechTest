//
//  StaffListVM.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import Foundation

class StaffListVM {
    func getStaffList(pageNumber: String, completion: @escaping(Result<StaffListResponse, APIError>) -> Void) {
        APIManager.shared.getStaffList(pageNumber: pageNumber, completion: completion)
    }
}
