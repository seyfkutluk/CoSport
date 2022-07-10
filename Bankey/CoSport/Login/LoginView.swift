//
//  LoginView.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 29.06.2022.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let stackView = UIStackView()
    let userNameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()  // basically a line is a view in different colour
    
    override init(frame: CGRect) {  // overrides the parent class in this case override UIView class
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {    // required tells that all subclasses of this class should write this method.
        fatalError("init(coder:) hasn't been implemented")
    }
    
//    override var intrinsicContentSize: CGSize { // default size
//        return CGSize(width: 200, height: 200)
//    }
}

extension LoginView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray3
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false // view Automatizing
        userNameTextField.placeholder = "Username"
        userNameTextField.delegate = self   // register ourself as a delegate to textfield
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false // view Automatizing
        passwordTextField.isSecureTextEntry = true  // place that shows ... not let you see password
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self   // register ourself as a delegate to textfield
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        layer.cornerRadius = 5  // reaches back of the view and makes a circle in the corners
        clipsToBounds = true    // clips the corners
    }
    
    func layout() {
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)   // add text field to view
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

// MARK: UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) -> Bool {
        true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    }
}

