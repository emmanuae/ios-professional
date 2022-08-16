//
//  ViewController.swift
//  Bankey
//
//  Created by E A on 15/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signinButton = UIButton(type: .system)
    let errorMessage = UILabel()
    
    var username:String? {
        return loginView.usernameTextField.text
    }
    var password:String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        style()
        layout()
    }

}
extension LoginViewController {
    
    private func style() {
        
      
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        signinButton.configuration = .filled()
        signinButton.configuration?.imagePadding = 8 // for indicator spacing
        signinButton.setTitle("Sign In", for: [])
        signinButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.textAlignment = .center
        errorMessage.textColor = .systemRed
        errorMessage.numberOfLines = 0
        errorMessage.isHidden = true
        
    }
    private func layout(){
        view.addSubview(loginView)
        view.addSubview(signinButton)
        view.addSubview(errorMessage)
        
     
        //Login
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //Button
        NSLayoutConstraint.activate([
            signinButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signinButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signinButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        //errorLabel
        NSLayoutConstraint.activate([
            errorMessage.topAnchor.constraint(equalToSystemSpacingBelow: signinButton.bottomAnchor, multiplier: 2),
            errorMessage.leadingAnchor.constraint(equalTo: signinButton.leadingAnchor),
            errorMessage.trailingAnchor.constraint(equalTo: signinButton.trailingAnchor)
        ])
    }
    
}
//Mark:Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessage.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / Password Should never be nil ")
            return
        }
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / Password cannot be blank")
        }
        else if username == "EA" && password == "Welcome" {
            signinButton.configuration?.showsActivityIndicator = true
        }
        else {
            configureView(withMessage: "Incorrect Username / Password")
        }
    }
    private func configureView(withMessage message:String) {
        errorMessage.isHidden = false
        errorMessage.text = message
    }
}
