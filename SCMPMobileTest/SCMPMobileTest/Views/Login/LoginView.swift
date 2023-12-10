//
//  LoginView.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func didClickLoginButton(email: String, password: String)
}

class LoginView: UIView {
    var delegate: LoginViewDelegate?
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "SCMPMobileTest"
        lb.font = UIFont.boldSystemFont(ofSize: 30)
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    private let emailTextfiled: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Please Input Your Email"
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.anchor(height: 40)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Please Input Your Password"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 5
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.anchor(height: 40)
        return tf
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Login", for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor("#637bfe").cgColor
        btn.backgroundColor = UIColor("#2a3eb1")
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.anchor(height: 50)
        return btn
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.backgroundColor = UIColor("#FFFFFF")
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private func mainStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       emailTextfiled,
                                                       passwordTextField,
                                                       loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 15
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = UIColor("#bbdefb")
        let stackView = self.mainStackView()
        self.addSubview(stackView)
        self.addSubview(self.loadingIndicator)
        stackView.anchor(width: self.frame.width - 60)
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.loginButton.addTarget(self, action: #selector(didClickLoginButton), for: .touchUpInside)
        self.loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    @objc private func didClickLoginButton() {
        guard let email = emailTextfiled.text, let password = passwordTextField.text else {return}
        self.loadingIndicator.startAnimating()
        self.delegate?.didClickLoginButton(email: email, password: password)
    }
    
}
