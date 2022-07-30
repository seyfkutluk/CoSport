//
//  AccountSummaryHeaderView.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 10.07.2022.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var firstHeader: UILabel!
    @IBOutlet weak var nameOfUser: UILabel!
    @IBOutlet weak var dateHeader: UILabel!
    let shakeBellView = ShakeyBellView()
    
    struct viewModel {
        let firstHeaderLabel: String
        let nameOfUserLabel: String
        let dateHeaderLabel: Date
        
        var dateFormatted: String {
            return date.monthDayYearString
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        setupShakeyBell()
    }
    
    private func setupShakeyBell() {
        shakeBellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeBellView)
        
        NSLayoutConstraint.activate([
            shakeBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakeBellView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(viewModel: ViewModel) {
        firstHeaderLabel.text = viewModel.firstHeader
        nameOfUserLabel.text = viewModel.nameOfUser
        dateHeaderLabel.text = viewModel.dateHeader
    }
}
