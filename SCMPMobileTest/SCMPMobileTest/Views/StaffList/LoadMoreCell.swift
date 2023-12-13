//
//  LoadMoreCell.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/10/23.
//

import UIKit

protocol LoadMoreCellDelegate: AnyObject {
    func didClickLoadMore()
}

class LoadMoreCell: UITableViewCell {
    static let identifier = "loadMoreCell"
    
    var delegate: LoadMoreCellDelegate?
    
    let loadMoreButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Load More", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor("#f0f4c3").cgColor
        btn.backgroundColor = UIColor("#c0ca33")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.anchor(width: 200, height: 50)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.addSubview(loadMoreButton)
        self.loadMoreButton.addTarget(self, action: #selector(didClickLoadMoreButton), for: .touchUpInside)
        self.loadMoreButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.loadMoreButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    @objc private func didClickLoadMoreButton() {
        self.delegate?.didClickLoadMore()
    }
}
