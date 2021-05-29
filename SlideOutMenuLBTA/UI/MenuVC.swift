//
//  MenuVC.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 29/05/2021.
//

import UIKit

class MenuVC: UIViewController {
    
    // MARK:- Views
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK:- Handler
    private let handler  = MenuHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        for i in 1 ... 5 {
            handler.indexData.append("menu Item row  \(i)")
        }
        tableView.reloadData()
        
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.backgroundColor = .blue
        handler.setup(tableView)
    }
}


// MARK:- MenuHandler
class MenuHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var indexData = [String]()
    
    func setup(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = indexData[indexPath.row]
        return cell
    }
    
    
}
