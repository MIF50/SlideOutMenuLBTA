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
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK:- SlideMenu
    fileprivate var leadingAnchorRightView: NSLayoutConstraint!
    fileprivate var trailingAnchorRightView: NSLayoutConstraint!
    fileprivate var isMenuOpen = false
    fileprivate let menuWidth:CGFloat = 300
    fileprivate let thresholdVelocity:CGFloat = 500
    
    fileprivate var rightVC: UIViewController = UINavigationController(rootViewController: HomeVC())
    fileprivate let menuVC = ChatRoomMenuVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewControllers()
        configurePanGesture()
        configureTapGesture()
    }
    
    @objc private func didTapDismiss() {
        hideMenu()
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        x = isMenuOpen ? x + menuWidth : x
        x = min(x, menuWidth)
        x = max(0,x)
        
        leadingAnchorRightView.constant = x
        trailingAnchorRightView.constant = x
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
    
    func openMenu() {
        isMenuOpen = true
        leadingAnchorRightView.constant = menuWidth
        trailingAnchorRightView.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func hideMenu() {
        isMenuOpen = false
        leadingAnchorRightView.constant = 0
        trailingAnchorRightView.constant = 0
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpen ? .lightContent : .default
    }
    
    func didSelectMenuItem(vc: UIViewController) {
        performRightViewCleanUp()
        hideMenu()
        rightVC = vc
        rightContainerView.addSubview(rightVC.view)
        addChild(rightVC)
        rightContainerView.bringSubviewToFront(darkCoverView)
    }
    
    private func performRightViewCleanUp() {
        rightVC.view.removeFromSuperview()
        rightVC.removeFromParent()
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
            rightContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            menuContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            menuContainerView.trailingAnchor.constraint(equalTo: rightContainerView.leadingAnchor),
            menuContainerView.widthAnchor.constraint(equalToConstant: menuWidth),
            menuContainerView.bottomAnchor.constraint(equalTo: rightContainerView.bottomAnchor)
            
        ])
        leadingAnchorRightView = rightContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        leadingAnchorRightView.isActive = true
        trailingAnchorRightView = rightContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        trailingAnchorRightView.isActive = true
    }
    
    fileprivate func configureViewControllers() {
        
        let homeView = rightVC.view!
        let menuView = menuVC.view!
                
        rightContainerView.addSubview(homeView)
        menuContainerView.addSubview(menuView)
        rightContainerView.addSubview(darkCoverView)

        homeView.anchor(
            top: rightContainerView.topAnchor,
            leading: rightContainerView.leadingAnchor,
            bottom: rightContainerView.bottomAnchor,
            trailing: rightContainerView.trailingAnchor
        )
        
        menuView.anchor(
            top: menuContainerView.topAnchor,
            leading: menuContainerView.leadingAnchor,
            bottom: menuContainerView.bottomAnchor,
            trailing: menuContainerView.trailingAnchor
        )
        
        darkCoverView.anchor(
            top: rightContainerView.topAnchor,
            leading: rightContainerView.leadingAnchor,
            bottom: rightContainerView.bottomAnchor,
            trailing: rightContainerView.trailingAnchor
        )
    
        addChild(rightVC)
        addChild(menuVC)
    }
    
    fileprivate func configurePanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    fileprivate func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
}
