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
    
    private let darkCoverView = UIView()
    
    // MARK:- Handler
    private let handler = HomeHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationItems()
    }
    
    @objc private func didTapOpen() {
        let mainWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let baseSlidingVC = mainWindow?.rootViewController as? BaseSlidingVC
        baseSlidingVC?.openMenu()
    }
    
    @objc private func didTapHide() {
        let mainWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let baseSlidingVC = mainWindow?.rootViewController as? BaseSlidingVC
        baseSlidingVC?.hideMenu()
    }
    
    // MARK:- Private Method
    fileprivate func configureTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        handler.setup(tableView)
    }
    
    fileprivate func configureNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(didTapOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(didTapHide))
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

