//
//  ViewController.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 28.06.2022.
//

import UIKit // This controls whereo  the wiew will be placed and other settings

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate? // avoid retain cycles they send strong reference
    
    var username: String? { // shortcut to reach username    optional string
        return loginView.userNameTextField.text
    }
    
    var password: String? { // shortcut to reach password
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false  // spinning indicator stopping wiew view dissappear
    }

}

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false // necessary for auto showing of view
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8    // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true   // default it is true
        
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([   // constraint that shows where the view will be placed
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor) ,
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1) ,
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([   // constraint that shows where the view will be placed
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 1)
            // beneath login view
        ])
        
        NSLayoutConstraint.activate([
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 1)
        ])
    }
}

// MARK: Actions

extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {   // username = username converts optional string to normal string
            assertionFailure("Username / password should never be nil") // if get here programmer error
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Cannot be empty")
            return
        }
        
        if username == "A" && password == "a" {
            signInButton.configuration?.showsActivityIndicator = true   // the turning circle in sign in
            delegate?.didLogin()    // if the name and password is right ew send didlogin signal
        } else {
            configureView(withMessage: "Incorrenct password or name")
        }
    }
    
    private func configureView(withMessage message: String) {   // argument parameters
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

