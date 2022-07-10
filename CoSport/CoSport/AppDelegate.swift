//
//  AppDelegate.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 28.06.2022.
//

import UIKit

let appColor: UIColor = .systemTeal // like an global variable

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    let accountSummaryController = AccountSummaryViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self // make us delegate send us signals
        onboardingViewController.delegate = self    // make us delegate send us signals
        
        let vc = mainViewController
        vc.setStatusBar()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = vc

        return true
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {    // implement protocol to Appdelegate to be able to listen to signal
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(mainViewController)
        }
        else {
            setRootViewController(onboardingViewController)
        }
    }
}

extension AppDelegate: LogoutDelegate {    // implement protocol to Appdelegate to be able to listen to signal
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate: OnboardingViewControllerDelegate {    // implement protocol to Appdelegate to be able to listen to signal
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        print("Onboardign is done")  // print in console
        setRootViewController(mainViewController)
    }
}

