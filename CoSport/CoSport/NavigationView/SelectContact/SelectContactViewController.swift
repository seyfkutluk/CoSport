//
//  SelectContactViewController.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 3.08.2022.
//

import Foundation
import UIKit
import TinyConstraints
import Contacts
import ContactsUI

class SelectContactViewController: UIViewController, CNContactPickerDelegate {
    
    lazy var button0: SelectContactButton = {
        let button = SelectContactButton()
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(button0)
        button0.edgesToSuperview(excluding: .bottom, insets: .top(36) + .left(12) + .right(12), usingSafeArea: true)
        button0.height(50)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: UISelectionFeedbackGenerator(), action: #selector(buttonTapped))
        
    }
}
