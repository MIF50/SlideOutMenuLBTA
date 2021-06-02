//
//  ChatRoomMenuContainerVC.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 01/06/2021.
//

import UIKit

class ChatRoomMenuContainerVC: UIViewController {
    
    // MARK:- Views
    private let searchContainer = SearchContainerView()
    private let chatRoomMenuVC = ChatRoomMenuVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
        configureContainerSearch()
        configureChatRoomMenuVC()
    }
    
    private func configureContainerSearch() {
        searchContainer.backgroundColor = #colorLiteral(red: 0.345679854, green: 0.313898157, blue: 0.339062031, alpha: 1)
        view.addSubview(searchContainer)
        searchContainer.anchor(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor
        )
        searchContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 64).isActive = true
        searchContainer.delegate = chatRoomMenuVC
        
    }
    
    private func configureChatRoomMenuVC() {
        let chatRoomMenuView = chatRoomMenuVC.view!
        view.addSubview(chatRoomMenuView)
        chatRoomMenuView.anchor(
            top: searchContainer.bottomAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor
        )
    }
}

class SearchContainerView: UIView, UISearchBarDelegate {
    
    // MARK:- Views
    private let imageSearch: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "rocket")
        image.size(width: 42, height: 42)
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.setup(background: #colorLiteral(red: 0.4322252143, green: 0.2816649512, blue: 0.3725126183, alpha: 1), inputText: UIColor.white, placeholderText: UIColor.gray, image: UIColor.gray)
        search.placeholder = "Enter your filter"
        return search
    }()
    
    // MARK:- Delegaet
    var delegate: SearchContainerViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSearchContainer()
    }
    
    private func configureSearchContainer() {
        let hstack = UIStackView(arrangedSubviews: [imageSearch,searchBar])
        hstack.axis = .horizontal
        hstack.spacing = 4
        
        addSubview(hstack)
        hstack.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 12, bottom: 6, right: 6)
        )
        
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            delegate?.onClear()
            return
        }
        delegate?.onSearch(query: searchText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol SearchContainerViewDelegate {
    func onSearch(query: String)
    func onClear()
}
// MARK:- SearchBarExt
extension UISearchBar {
    
    func setup(background: UIColor = .white, inputText: UIColor = .black, placeholderText: UIColor = .gray, image: UIColor = .black) {

           self.searchBarStyle = .minimal
           self.barStyle = .default

           // IOS 12 and lower:
           for view in self.subviews {

               for subview in view.subviews {
                   if subview is UITextField {
                       if let textField: UITextField = subview as? UITextField {
                           textField.backgroundColor = background
                           textField.textColor = inputText

                           textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeholderText])

                           if let leftView = textField.leftView as? UIImageView {
                               leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                               leftView.tintColor = image
                           }

                           let backgroundView = textField.subviews.first
                           backgroundView?.backgroundColor = background
                           backgroundView?.layer.cornerRadius = 10.5
                           backgroundView?.layer.masksToBounds = true

                       }
                   }
               }
           }

           // IOS 13 only:
           if let textField = self.value(forKey: "searchField") as? UITextField {
               textField.backgroundColor = background
               textField.textColor = inputText
               textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeholderText])
            
               if let leftView = textField.leftView as? UIImageView {
                   leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                   leftView.tintColor = image
               }
           }

       }
}
