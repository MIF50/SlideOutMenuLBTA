//
//  BookMarkVC.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 31/05/2021.
//

import UIKit

class BookMarkVC: UIViewController {
    
    // MARK:- Views
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK:- Handler
    private let handler = BookMarkHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        handler.setup(tableView)
        handler.indexData.append("")
        handler.indexData.append("")
        handler.indexData.append("")
        handler.indexData.append("")
        tableView.reloadData()
    }
}

// MARK:- BookMarkHandler
class BookMarkHandler: NSObject,UITableViewDataSource, UITableViewDelegate {
    
    var indexData = [String]()
    
    func setup(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        indexData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexData[indexPath.row])"
        return cell
    }
    
}
