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
    
//    let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
    let boldSearch = UIImage(systemName: "search")
    
    var viewController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        self.setImage(boldSearch, for: .normal)
        backgroundColor = .systemRed
//        setTitle("Rehber", for: .normal)
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
    
}