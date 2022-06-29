//
//  LoginVİew.swift
//  Bankey
//
//  Created by Seyfülmülük Kutluk on 29.06.2022.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    override init(frame: CGRect) {  // overrides the parent class in this case override UIView class
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {    // required tells that all subclasses of this class should write this method.
        fatalError("init(coder:) hasn't been implemented")
    }
    
    override var intrinsicContentSize: CGSize { // for storyboards
        return CGSize(width: 200, height: 200)
    }
}

extension LoginView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        
    }
}


