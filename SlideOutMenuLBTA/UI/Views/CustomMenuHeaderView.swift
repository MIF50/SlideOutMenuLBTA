//
//  CustomMenuHeaderView.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 30/05/2021.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    // MARK:- Views
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "girl_profile")
        image.backgroundColor  = UIColor.red
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.size(width: 55, height: 55)
        image.layer.cornerRadius = 55 / 2
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Brain Voong"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let usernameLabel : UILabel = {
        let label = UILabel()
        label.text = "@buildthatapp"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let stateLabel : UILabel = {
        let label = UILabel()
        label.text = "42 Following 7091 Followers"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureVStack()
        configureStateAtrributedText()
    }
    
    fileprivate func configureVStack() {
        let vstack = vstack(
            UIView(),
            image,
            SpaceView(space: 4),
            titleLabel
            ,usernameLabel,
            SpaceView(space: 16)
            ,stateLabel
        )
        vstack.spacing = 4
        vstack.alignment = .top
        vstack.distribution = .fill
        vstack.margin(.init(top: 24, left: 24, bottom: 24, right: 24))
        vstack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vstack)
        vstack.fillSuperview()
    }
    
    fileprivate func configureStateAtrributedText() {
        stateLabel.font = UIFont.systemFont(ofSize: 15)
        let attributedText = NSMutableAttributedString(string: "42 ",attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following ",attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ",attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers ",attributes: [.foregroundColor: UIColor.black]))
        stateLabel.attributedText = attributedText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
