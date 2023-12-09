//
//  StaffListVC.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import UIKit

class StaffListVC: UIViewController {
    
    private let token: String
    private var viewModel: StaffListVM!
    private var pageNumber: Int = 1
    private var staffListView: StaffListView!
    
    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = StaffListVM()
        self.setupView()
        fetchData(1)
    }
    
    private func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.staffListView = StaffListView(frame: self.view.frame, token: self.token)
        self.view.addSubview(staffListView)
    }
    
    
    func fetchData(_ pageNumber: Int) {
        viewModel.getStaffList(pageNumber: "\(pageNumber)") { result in
            switch result {
            case .success(let list):
                self.staffListView.setData(stafflist: list)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
