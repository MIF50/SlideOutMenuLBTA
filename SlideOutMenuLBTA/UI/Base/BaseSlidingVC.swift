//
//  BaseSlidingVC.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 30/05/2021.
//

import UIKit

class RightContainerView:UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}

class BaseSlidingVC: UIViewController {
    
    // MARK:- Views
    let rightContainerView: RightContainerView = {
        let view = RightContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let menuContainerView: MenuContainerView = {
        let view = MenuContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    private let darkCoverView : DarkCoverView = {
        let view = DarkCoverView()
        view.alpha = 0
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK:- SlideMenu
    fileprivate var leadingAnchorRedView: NSLayoutConstraint!
    fileprivate var isMenuOpen = false
    fileprivate let menuWidth:CGFloat = 300
    fileprivate let thresholdVelocity:CGFloat = 500
    
    fileprivate var rightViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        configureView()
        configurePanGesture()
        configureViewControllers()
    }
    
    @objc private func handlePane(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        x = isMenuOpen ? x + menuWidth : x
        x = min(x, menuWidth)
        x = max(0,x)
        
        leadingAnchorRedView.constant = x
        darkCoverView.alpha = x / menuWidth
        if gesture.state == .ended {
            handleEnd(gesture)
        }
    }
    
    private func handleEnd(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        if isMenuOpen {
            if abs(velocity.x) > thresholdVelocity {
                hideMenu()
                return
            }
            if abs(translation.x) > menuWidth / 2 {
                hideMenu()
            } else {
                openMenu()
            }
        } else {
            if velocity.x > thresholdVelocity {
                openMenu()
                return
            }
            
            if translation.x > menuWidth / 2 {
                openMenu()
            } else {
                hideMenu()
            }
        }
    }
    
    private func openMenu() {
        isMenuOpen = true
        leadingAnchorRedView.constant = menuWidth
        performAnimations()
    }
    
    private func hideMenu() {
        isMenuOpen = false
        leadingAnchorRedView.constant = 0
        performAnimations()
    }
    
    func didSelectMenuItem(at indexPath: IndexPath,vc: UIViewController?) {
        performRightViewCleanUp()
        
        if let vc = vc {
            rightContainerView.addSubview(vc.view)
            addChild(vc)
            rightViewController = vc
        }
        rightContainerView.bringSubviewToFront(darkCoverView)
        hideMenu()
    }
    
    private func performRightViewCleanUp() {
        rightViewController?.view.removeFromSuperview()
        rightViewController?.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut
        ) {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpen ? 1 : 0
        }
    }
     
    fileprivate func configureView() {
        view.addSubview(rightContainerView)
        view.addSubview(menuContainerView)
        
        NSLayoutConstraint.activate([
            rightContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            rightContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            menuContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            menuContainerView.trailingAnchor.constraint(equalTo: rightContainerView.leadingAnchor),
            menuContainerView.widthAnchor.constraint(equalToConstant: menuWidth),
            menuContainerView.bottomAnchor.constraint(equalTo: rightContainerView.bottomAnchor)
            
        ])
        leadingAnchorRedView = rightContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0)
        leadingAnchorRedView.isActive = true
    }
    
    fileprivate func configurePanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePane))
        view.addGestureRecognizer(panGesture)
    }
    
    fileprivate func configureViewControllers() {
        rightViewController = HomeVC()
        let menuVC = MenuVC()
        
        let homeView = rightViewController!.view!
        let menuView = menuVC.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        rightContainerView.addSubview(homeView)
        rightContainerView.addSubview(darkCoverView)
        menuContainerView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: rightContainerView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: rightContainerView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: menuContainerView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: menuContainerView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: menuContainerView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: menuContainerView.trailingAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: rightContainerView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: rightContainerView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: rightContainerView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: rightContainerView.trailingAnchor)
        ])
        
        addChild(rightViewController!)
        addChild(menuVC)
    }
}
