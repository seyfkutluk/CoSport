//
//  SelectContactViewController.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 3.08.2022.
//

import Foundation
import UIKit
//import TinyConstraints
import Contacts
import ContactsUI

class SelectContactViewController: UIViewController {
    
    lazy var button0: SelectContactButton = {
        let button = SelectContactButton()
        return button
    }()
    
    var emailContent = UITextField()
    
    override func viewDidLoad() {
        emailContent.textContentType = .emailAddress
        view.backgroundColor = .white
        button0.sizeToFit()
//        button0.sizeThatFits(CGSize(width: 50, height: 50))
        view.addSubview(button0)
        view.addSubview(emailContent)
    }
}
