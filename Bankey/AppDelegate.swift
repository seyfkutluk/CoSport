//
//  AppDelegate.swift
//  Bankey
//
//  Created by Seyfülmülük Kutluk on 28.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self // make us delegate send us signals
        onboardingViewController.delegate = self    // make us delegate send us signals
        
//        window?.rootViewController = loginViewController
//        window?.rootViewController = LoginViewController()  // refactor rename change name
        window?.rootViewController = onboardingViewController
        
        
        
        return true
    }
    
}

extension AppDelegate: LoginViewControllerDelegate {    // implement protocol to Appdelegate to be able to listen to signal
    func didLogin() {
        print("We are in")  // print in console
    }
}

extension AppDelegate: OnboardingViewControllerDelegate {    // implement protocol to Appdelegate to be able to listen to signal
    func didFinishOnboarding() {
        print("Onboardign is done")  // print in console
    }
}

