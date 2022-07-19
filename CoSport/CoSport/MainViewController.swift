//
//  MainViewController.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 10.07.2022.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let wikipediaVC = WikipediaViewController()
        let moreVC = MoreViewController()
        
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "home")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "more")
        wikipediaVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "wikipedia")
        
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let wikipediaNC = UINavigationController(rootViewController: wikipediaVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        summaryNC.navigationBar.barTintColor = appColor
        hideNavigationBarline(summaryNC.navigationBar)
        
        let tabBarList = [summaryNC, moreNC, wikipediaNC]
        
        viewControllers = tabBarList
    }
    
    private func hideNavigationBarline(_ navigationBar: UINavigationBar) {  // hides the navigation bar line
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemRed
    }
}
