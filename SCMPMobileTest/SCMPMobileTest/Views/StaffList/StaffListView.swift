//
//  StaffListView.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import UIKit

protocol StaffListViewDelegate: AnyObject {
    func didClickLoadMore()
}

class StaffListView: UIView {
    var delegate: StaffListViewDelegate?
    private var staffListResponse = StaffListResponse(page: 0, perPage: 0, total: 0, totalPages: 0, data: [])
    private var staffList = [Staff]()
    private var isLastPage: Bool = false
    private var isLoading: Bool = false
    
    let tokenLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.bounces = true
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(StaffCell.self, forCellReuseIdentifier: StaffCell.identifier)
        tv.register(LoadMoreCell.self, forCellReuseIdentifier: LoadMoreCell.identifier)
        return tv
    }()
    
    init(frame: CGRect ,token: String) {
        super.init(frame: frame)
        self.tokenLabel.text = "Token: \(token)"
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = UIColor("#f0f4c3")
        self.addSubview(tokenLabel)
        self.addSubview(tableView)
        self.tokenLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        self.tokenLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.anchor(top: self.tokenLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func setStaffList(list: [Staff], isLastPage: Bool) {
        self.staffList = list
        self.isLastPage = isLastPage
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

extension StaffListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.staffList.count
        case 1:
            return self.isLastPage ? 0 : 1
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaffCell.identifier, for: indexPath) as? StaffCell else {return UITableViewCell()}
            cell.selectionStyle = .none
            let data = self.staffList[indexPath.row]
            cell.setData(data: data)
            return cell
        }else {
            guard let loadMoreCell = tableView.dequeueReusableCell(withIdentifier: LoadMoreCell.identifier, for: indexPath) as? LoadMoreCell else {return UITableViewCell()}
            loadMoreCell.delegate = self
            loadMoreCell.showLoading(status: true)
            loadMoreCell.selectionStyle = .none
            return loadMoreCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110
        }else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.staffList.count - 1, !isLastPage {
            print("loading more data")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                self.delegate?.didClickLoadMore()
            }
            
        }
    }
}

// MARK: - loadMoreCell delegate
extension StaffListView: LoadMoreCellDelegate {
    func didClickLoadMore() {
        self.delegate?.didClickLoadMore()
    }
}
