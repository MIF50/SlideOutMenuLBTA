//
//  ListVC.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 31/05/2021.
//

import UIKit

class ListVC: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "List"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        label.fillSuperview()
    }
}
