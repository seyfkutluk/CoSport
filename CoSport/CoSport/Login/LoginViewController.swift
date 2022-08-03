//
//  ViewController.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 28.06.2022.
//
//  Animations: You give it a starting point and ending point and after that you animate between starting and ending point
//  Animations: You can use Debug -> Slow Animations To look hoe your animations react this will slow down everything
//  You can check Core Animation Apple Documentation

import UIKit // This controls whereo  the wiew will be placed and other settings
import SwiftUI
import FirebaseAuth

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    let titleOf = UITextView()
    
    weak var delegate: LoginViewControllerDelegate? // avoid retain cycles they send strong reference
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        //        self.view.backgroundColor = .systemGray
    }
    var username: String? { // shortcut to reach username    optional string
        return loginView.userNameTextField.text
    }
    
    var password: String? { // shortcut to reach password
        return loginView.passwordTextField.text
    }
    
    var leadingEdgeScreen: CGFloat = 0
    var leadingOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint? // we take the constraint as a variable so we can change it to animate
    var subtitleTrailingAnchor: NSLayoutConstraint? // we take the constraint as a variable so we can change it to animate
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
}

extension LoginViewController {
    
    private func style() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "CoSport"
        titleLabel.alpha = 0
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "The best place to start finding gym friends"
        subtitleLabel.alpha = 0
        
        loginView.translatesAutoresizingMaskIntoConstraints = false // necessary for auto showing of view
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8    // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.tintColor = .systemPurple
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true   // default it is true
        
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        
        // Title
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingOffScreen)
        titleLeadingAnchor?.isActive = true // since it is in outside of it we should put it true
        
        // Subtitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor)
        ])
        
        subtitleTrailingAnchor = subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: leadingOffScreen)
        subtitleTrailingAnchor?.isActive = true
        
        //Loginview username password part
        NSLayoutConstraint.activate([   // constraint that shows where the view will be placed
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor) ,
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1) ,
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
                                    ])
        
        //Sign In
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
        
        // MARK: TODO Password logic will be added
        signInButton.configuration?.showsActivityIndicator = true   // the turning circle in sign in
        delegate?.didLogin()    // if the name and password is right ew send didlogin signal
        // MARK: TODO Password logic will be added
        
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
        shakeButton()   // if wrong shake button
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"    // in position x
        animation.values = [0,10, -10, 10, 0]   // start from 0 10 to left 10 to right 0 again
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]    // do it in this timing 16 precent 50 percent just like that
        animation.duration = 0.3    //
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")  // we name it key shake it is changeable
    }
}

//  MARK: - Animations
//  MARK: - UIVİewPropertyAnimator is being used with parameters
extension LoginViewController {
    private func animate() {
        let duration = 0.5
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {  // Animate in the previpus contraineted value -1000 to 16
            self.titleLeadingAnchor?.constant = self.leadingEdgeScreen
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
        
        let animator1 = UIViewPropertyAnimator(duration: duration*3, curve: .easeInOut) {  // Animate in the previpus contraineted value -1000 to 16
            self.subtitleTrailingAnchor?.constant = self.leadingEdgeScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation(afterDelay: 1)
        
        let animator2 = UIViewPropertyAnimator(duration: duration*4, curve: .easeInOut) {  // Animate in the previpus contraineted value -1000 to 16
            self.titleLabel.alpha = 1   // how visible translative changed from 0 to 1
            self.subtitleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 1)
    }
}
