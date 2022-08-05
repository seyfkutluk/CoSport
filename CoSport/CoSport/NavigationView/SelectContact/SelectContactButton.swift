//
//  SelectContactButton.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 3.08.2022.
//

import Contacts
import ContactsUI
import Foundation
import UIKit

class SelectContactButton: UIButton {

    let boldSearch = UIImage(systemName: "search")
    
    var viewController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        self.setImage(boldSearch, for: .normal)
        backgroundColor = .systemRed
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        print("dscs")
        let vc = CNContactPickerViewController()
        vc.delegate = self
        viewController.present(vc, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectContactButton: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        // update textfield value when selected contact email
        if let email = contact.emailAddresses.first?.value as String? {
//            emailTextField.text = email
            print("\(email)")
        }
        
//        if let contactNumber = contact.phoneNumbers.first?.value as String? {
//            print("\(contactNumber)")
//        }
    }
}
