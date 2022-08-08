//
//  CreateAccountViewController.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 8.08.2022.
//

import UIKit // This controls whereo  the wiew will be placed and other settings
import SwiftUI
import FirebaseAuth

class CreateAccountViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let createAccountView = CreateAccountView()
    let createAccountButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    let titleOf = UITextView()
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        //        self.view.backgroundColor = .systemGray
    }
    var username: String? { // shortcut to reach username    optional string
        return createAccountView.userNameTextField.text
    }
    
    var password: String? { // shortcut to reach password
        return createAccountView.passwordTextField.text
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
        createAccountButton.configuration?.showsActivityIndicator = false  // spinning indicator stopping wiew view dissappear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
}

extension CreateAccountViewController {
    
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
        
        createAccountView.translatesAutoresizingMaskIntoConstraints = false // necessary for auto showing of view
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.configuration = .filled()
        createAccountButton.configuration?.imagePadding = 8    // for indicator spacing
        createAccountButton.setTitle("Create Account", for: [])
        createAccountButton.tintColor = .systemPurple
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true   // default it is true
        
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(createAccountView)
        view.addSubview(createAccountButton)
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
            createAccountView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.leadingAnchor.constraint(equalTo: createAccountView.leadingAnchor)
        ])
        
        subtitleTrailingAnchor = subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: leadingOffScreen)
        subtitleTrailingAnchor?.isActive = true
        
        //Loginview username password part
        NSLayoutConstraint.activate([   // constraint that shows where the view will be placed
            createAccountView.centerYAnchor.constraint(equalTo: view.centerYAnchor) ,
            createAccountView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1) ,
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: createAccountView.trailingAnchor, multiplier: 1)
                                    ])
        
        //Sign In
        NSLayoutConstraint.activate([   // constraint that shows where the view will be placed
            createAccountButton.leadingAnchor.constraint(equalTo: createAccountView.leadingAnchor),
            createAccountButton.trailingAnchor.constraint(equalTo: createAccountView.trailingAnchor),
            createAccountButton.topAnchor.constraint(equalToSystemSpacingBelow: createAccountView.bottomAnchor, multiplier: 1)
            // beneath login view
                                    ])
        
        NSLayoutConstraint.activate([
            errorMessageLabel.leadingAnchor.constraint(equalTo: createAccountView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: createAccountView.trailingAnchor),
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: createAccountButton.bottomAnchor, multiplier: 1)
        ])
    }
}

// MARK: Actions

extension CreateAccountViewController {
    @objc func createAccountButtonTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
//        Authorize()
        createAccount()
    }

    private func createAccount() {
        
        // MARK: TODO Password logic will be added
        createAccountButton.configuration?.showsActivityIndicator = true   // the turning circle in sign in
//        delegate?.didLogin()    // if the name and password is right ew send didlogin signal
        // MARK: TODO Password logic will be added
        
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
        createAccountButton.layer.add(animation, forKey: "shake")  // we name it key shake it is changeable
    }
}

//  MARK: - Animations
//  MARK: - UIVİewPropertyAnimator is being used with parameters
extension CreateAccountViewController {
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
