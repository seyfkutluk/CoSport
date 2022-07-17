//
//  OnboardingContainerViewController.swift
//  CoSport
//
//  Created by Seyfülmülük Kutluk on 6.07.2022.
//

import Foundation
import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    let closeButton = UIButton()
    let doneButton = UIButton()
    let backButton = UIButton()
    let nextButton = UIButton()
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController{   // current view controller being used
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else { return }
            nextButton.isHidden = index == pages.count - 1
            backButton.isHidden = index ==  0
            doneButton.isHidden = !(index == pages.count - 1)
        }
    }
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {  // init method
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(heroImageName: "football", titleText: "Trying to find someone to play")
        let page2 = OnboardingViewController(heroImageName: "camp", titleText: "someone to go camp with")
        let page3 = OnboardingViewController(heroImageName: "bicyle", titleText: "someone to go cycle with")
        let page4 = OnboardingViewController(heroImageName: "", titleText: "That is the perfect place Lets go")
        
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        view.backgroundColor = .systemGray
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
}

extension OnboardingContainerViewController {
    
    private func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        view.addSubview(closeButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("back", for: [])
        backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
        view.addSubview(backButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        view.addSubview(nextButton)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("done", for: [])
        doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
        view.addSubview(doneButton)
        
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.safeAreaLayoutGuide.trailingAnchor, multiplier: 2),
            nextButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
            
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.safeAreaLayoutGuide.trailingAnchor, multiplier: 2),
            doneButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
            
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            backButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
            
        ])
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        self.currentVC = pages[index - 1]
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        self.currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: -Actions

extension OnboardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    @objc func doneTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    @objc func backTapped(_ sender: UIButton) {
        guard let previousVC = getPreviousViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true)
        
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        guard let nextVC = getNextViewController(from: currentVC) else { return }
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
        
    }
}
