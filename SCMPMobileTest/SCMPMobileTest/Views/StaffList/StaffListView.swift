//
//  StaffListView.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import UIKit

protocol StaffListViewDelegate: AnyObject {
    func didClickLoadMore()
    func refreshTableView()
}

class StaffListView: UIView {
    var delegate: StaffListViewDelegate?
    private var staffListResponse = StaffListResponse(page: 0, perPage: 0, total: 0, totalPages: 0, data: [])
    private var staffList = [Staff]()
    private var isLastPage: Bool = false
    
    let tokenLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let tableView: UITableView = {
        let tv =  UITableView()
        tv.backgroundColor = .clear
        tv.bounces = false
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(StaffCell.self, forCellReuseIdentifier: StaffCell.identifier)
        tv.register(LoadMoreCell.self, forCellReuseIdentifier: LoadMoreCell.identifier)
        return tv
    }()
    
    init(frame: CGRect ,token: String) {
        super.init(frame: frame)
        tokenLabel.text = "Token: \(token)"
        setup()
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
    
    func refreshTableView() {
        self.tableView.reloadData()
    }
}

extension StaffListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isLastPage ? self.staffList.count : self.staffList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !self.isLastPage && indexPath.row == self.staffList.count {
            guard let loadMoreCell = tableView.dequeueReusableCell(withIdentifier: LoadMoreCell.identifier, for: indexPath) as? LoadMoreCell else {return UITableViewCell()}
            loadMoreCell.delegate = self
            return loadMoreCell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StaffCell.identifier, for: indexPath) as? StaffCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            let data = self.staffList[indexPath.row]
            cell.setData(data: data)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !self.isLastPage && indexPath.row == self.staffList.count {
            return 80
        }
        return 120
    }
    
}

extension StaffListView: LoadMoreCellDelegate {
    func didClickLoadMore() {
        self.delegate?.didClickLoadMore()
    }
}
