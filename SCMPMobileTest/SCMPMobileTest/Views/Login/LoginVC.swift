//
//  LoginVC.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import UIKit

class LoginVC: UIViewController {
    
    private var loginView: LoginView!
    private var viewModel: LoginVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginVM()
        self.setupView()
    }
    
    func setupView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.loginView.delegate = self
        self.view.addSubview(self.loginView)
        self.loginView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6 && password.count <= 10 && password.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
}

// MARK: - loginView delegate
extension LoginVC: LoginViewDelegate {
    func didClickLoginButton(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            showAlert(message: "Please enter both email and password.")
            return
        }
        
        guard isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return
        }
        
        guard isValidPassword(password) else {
            showAlert(message: "Password should be 6-10 characters and contain only letters and numbers.")
            return
        }
        
        self.viewModel.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.loginView.loadingIndicator.stopAnimating()
            }
            switch result {
            case .success(let token):
                print("login success, token => \(token)")
            case .failure(let error):
                switch error {
                case .custom(let errorMsg):
                    DispatchQueue.main.async {
                        self.showAlert(message: errorMsg)
                    }
                default:
                    print(error.localizedDescription)
                }
            }
        }
    }
}
