//
//  AccountSummaryBackgroundView.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 13.07.2022.
//

// MARK: TODO ADD BACKground image to tableview unused now
import Foundation
import UIKit

class AccountSummaryBackgroundView: UIView {
    
    let backgroundimage = UIImageView()
    
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

extension AccountSummaryBackgroundView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundimage.image = UIImage(systemName: "camp")

    }
    
    func layout() {

        NSLayoutConstraint.activate([
            backgroundimage.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            backgroundimage.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: backgroundimage.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: backgroundimage.bottomAnchor, multiplier: 1)
        ])
    
    }
}
