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
    
    private let loadMoreIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.anchor(width: 50, height: 50)
        indicator.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.addSubview(self.loadMoreIndicator)
        self.loadMoreIndicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.loadMoreIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    @objc private func didClickLoadMoreButton() {
        self.delegate?.didClickLoadMore()
    }
    
    func showLoading(status: Bool) {
        if (status) {
            self.loadMoreIndicator.startAnimating()
        }else {
            self.loadMoreIndicator.stopAnimating()
        }
    }
}
