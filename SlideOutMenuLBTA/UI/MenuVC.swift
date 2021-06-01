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
        handler.indexData = getMenuItems()
        tableView.reloadData()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        handler.setup(tableView)
    }
    
    // MARK:- Create MenuItems 
    private func getMenuItems() ->[MenuItem] {
        var items = [MenuItem]()
        items.append(MenuItem(image: #imageLiteral(resourceName: "profile"), title: "Home",didSelectMenu: {
            let nav = UINavigationController(rootViewController: HomeVC())
            return nav
        }))
        items.append(MenuItem(image: #imageLiteral(resourceName: "moments"), title: "Lists",didSelectMenu: {
            return ListVC()
        }))
        items.append(MenuItem(image: #imageLiteral(resourceName: "bookmarks"), title: "BookMarks",didSelectMenu: {
            let nav = UINavigationController(rootViewController: BookMarkVC())
            return nav
        }))
        items.append(MenuItem(image: #imageLiteral(resourceName: "moments"), title: "Moments",didSelectMenu: {
            let tab = UITabBarController()
            let nav = UINavigationController(rootViewController: MomentsVC())
            nav.tabBarItem.title = "moment"
            tab.viewControllers = [nav]
            return tab
        }))
        return items
    }
}


// MARK:- MenuHandler
class MenuHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var indexData = [MenuItem]()
    
    func setup(_ tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemMenuCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemMenuCell
        cell.menuItem = indexData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customMenuHeader = CustomMenuHeaderView()
        return customMenuHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseSlidingVC = UIApplication.shared.windows.filter { $0.isKeyWindow
        }.first?.rootViewController as? BaseSlidingVC
        let vc = indexData[indexPath.row].didSelectMenu()
        baseSlidingVC?.didSelectMenuItem(vc: vc)
    }
}

struct MenuItem {
    let image: UIImage
    let title: String
    let didSelectMenu:(()-> UIViewController)
}
