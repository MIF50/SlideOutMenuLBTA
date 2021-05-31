//
//  ItemMenuCell.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 30/05/2021.
//

import UIKit

class ItemMenuCell: UITableViewCell {
    
    var menuItem: MenuItem! {
        didSet {
            icon.image = menuItem.image
            menuLable.text = menuItem.title
        }
    }
    
    let icon: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.size(width: 44, height: 44)
        return image
    }()
    
    let menuLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHStackView()
    }
    
    private func configureHStackView() {
        let hstack = hstack(icon,menuLable,UIView())
        hstack.spacing = 12
        addSubview(hstack)
        hstack.fillSuperview()
        hstack.margin(.init(top: 16, left: 12, bottom: 16, right: 12))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
