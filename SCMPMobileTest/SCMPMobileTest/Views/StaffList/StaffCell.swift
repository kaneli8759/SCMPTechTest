//
//  StaffCell.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/10/23.
//

import UIKit

class StaffCell: UITableViewCell {
    static let identifier = "staffCell"
    
    private let avatarImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "person")
        iv.tintColor = .black
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let idLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .left
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private func contentStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [idLabel, nameLabel, emailLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        let stackView = self.contentStackView()
        self.contentView.addSubview(avatarImage)
        self.contentView.addSubview(stackView)
        self.avatarImage.anchor(left: self.contentView.leftAnchor, paddingLeft: 5, width: 80)
        self.avatarImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        stackView.anchor(top: self.contentView.topAnchor, left: self.avatarImage.rightAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingBottom: -10, paddingRight: 20)
    }

    
    func setData(data: Staff) {
        self.getImage(url: data.avatar)
        self.nameLabel.text = "Name: \(data.firstName) \(data.lastName)"
        self.idLabel.text = "ID: \(data.id)"
        self.emailLabel.text = "Email: \(data.email)"
    }
    
    private func getImage(url: String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let imageData = data else {return}
                DispatchQueue.main.async {
                    self.avatarImage.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }

}
