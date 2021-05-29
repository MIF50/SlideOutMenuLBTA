//
//  ViewController.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 29/05/2021.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK:- Views
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK:- Handler
    private let handler = HomeHandler()
    
    // MARK:- MenuVC
    private let menuVC = MenuVC()
    private let menuWidth: CGFloat = 300

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationItems()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.backgroundColor = .red
        handler.setup(tableView)
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(didTapOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(didTapHide))
    }
    
    @objc private func didTapOpen() {
        
        menuVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        mainWindow?.addSubview(menuVC.view)
        addChild(menuVC)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1, options: .curveEaseOut) {
            self.menuVC.view.transform = CGAffineTransform(translationX: self.menuWidth, y: 0)
        }

        
    }
    
    @objc private func didTapHide() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut) {
            self.menuVC.view.transform = .identity
        } completion: { finished in
            self.menuVC.view.removeFromSuperview()
            self.menuVC.removeFromParent()
        }
    }
}

// MARK:- HomeHandler
class HomeHandler: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    func setup(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
    
    
}

