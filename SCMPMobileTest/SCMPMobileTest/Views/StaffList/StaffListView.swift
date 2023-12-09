//
//  StaffListView.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import UIKit

class StaffListView: UIView {
    private var staffList = StaffListResponse(page: 0, perPage: 0, total: 0, totalPages: 0, data: [])
    
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
        self.tokenLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        self.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.anchor(top: self.tokenLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func setData(stafflist: StaffListResponse) {
        self.staffList = stafflist
    }
}

extension StaffListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.staffList.perPage
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StaffCell.identifier, for: indexPath) as? StaffCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let data = self.staffList.data[indexPath.row]
        cell.setData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
