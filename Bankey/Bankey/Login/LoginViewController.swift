//
//  ViewController.swift
//  Bankey
//
//  Created by E A on 15/08/22.
//

import UIKit


protocol LoginViewControllerDelegate:AnyObject {
    func didLogin()
}
protocol LogoutDelegate:AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    let loginView = LoginView()
    let signinButton = UIButton(type: .system)
    let errorMessage = UILabel()
    
    weak var delegate:LoginViewControllerDelegate?
    
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signinButton.configuration?.showsActivityIndicator = false 
    }

}
extension LoginViewController {
    
    private func style() {
        
        view.backgroundColor = .systemBackground
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
      
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
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        
        view.addSubview(loginView)
        view.addSubview(signinButton)
        view.addSubview(errorMessage)
        
        //Title
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //SubTitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
     
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
            delegate?.didLogin()
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
