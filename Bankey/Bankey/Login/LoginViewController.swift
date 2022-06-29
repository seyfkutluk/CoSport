//
//  ViewController.swift
//  Bankey
//
//  Created by Seyfülmülük Kutluk on 28.06.2022.
//

import UIKit
// This controls where the wiew will be placed and other settings
class LoginViewController: UIViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        // Do any additional setup after loading the view.
    }

}

extension LoginViewController {
    
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false // necessary for auto showing of view
    }
    
    private func layout() {
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([   // constraint that shows where the view will be placed
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor) ,
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1) ,
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
    }
}

