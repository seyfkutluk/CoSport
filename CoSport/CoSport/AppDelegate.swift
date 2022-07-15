//
//  AppDelegate.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 28.06.2022.
//

import UIKit
import WikipediaKit

let appColor: UIColor = .systemPurple // like an global variable2

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    let accountSummaryController = AccountSummaryViewController()
    
    override init() {
        WikipediaNetworking.appAuthorEmailForAPI = "seyfkutluk@gmail.com"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self // make us delegate send us signals
        onboardingViewController.delegate = self    // make us delegate send us signals
        registerNotifications()
        displayLogin()
        
        return true
    }
    
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    
    private func registerNotifications() {  // when we did get notification call didLogout
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .Logout, object: nil)
    }
    
    private func displayNextScreen() {
        if LocalState.hasOnboarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }
    
    private func prepMainView() {
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
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
        displayNextScreen()
    }
}

extension AppDelegate: LogoutDelegate {    // implement protocol to Appdelegate to be able to listen to signal
    @objc func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate: OnboardingViewControllerDelegate {    // implement protocol to Appdelegate to be able to listen to signal
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainView() 
        setRootViewController(mainViewController)
    }
}

