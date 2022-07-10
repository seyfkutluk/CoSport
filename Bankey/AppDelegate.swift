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
    let dummyViewController = DummyViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self // make us delegate send us signals
        onboardingViewController.delegate = self    // make us delegate send us signals
        dummyViewController.logoutDelegate = self
        
        window?.rootViewController = loginViewController
//        window?.rootViewController = LoginViewController()  // refactor rename change name
//        window?.rootViewController = onboardingViewController
        
        
        
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
                          duration: 0.7,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}


extension AppDelegate: LoginViewControllerDelegate {    // implement protocol to Appdelegate to be able to listen to signal
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(dummyViewController)
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
        setRootViewController(dummyViewController)
    }
}

