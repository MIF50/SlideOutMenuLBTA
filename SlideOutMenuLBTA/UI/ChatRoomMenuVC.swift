//
//  ChatRoomMenuVC.swift
//  SlideOutMenuLBTA
//
//  Created by MIF50 on 01/06/2021.
//

import UIKit

class ChatRoomMenuVC: UIViewController {
    

    // MARK:- Views
    private let tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    // MARK:- Handler
    private let handler = ChatRoomHandler()
    
    private var filterSearch: [ChatRoom] = ChatRoom.getChats()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        handler.setup(tableView)
        handler.indexData = ChatRoom.getChats()
        tableView.reloadData()
    }
}

// MARK:- SearchContainerViewDeleage
extension ChatRoomMenuVC: SearchContainerViewDelegate {
    
    func onSearch(query: String) {
        filterSearch = ChatRoom.search(query: query)
        handler.indexData = filterSearch
        tableView.reloadData()
    }
    
    func onClear() {
        filterSearch = ChatRoom.getChats()
        handler.indexData = filterSearch
        tableView.reloadData()
    }
}

// MARK:- Handler
class ChatRoomHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var indexData = [ChatRoom]()
    
    func setup(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.register(ChatRoomMenuCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexData[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ChatHeaderLabel()
        header.text = indexData[section].title
        header.textColor = #colorLiteral(red: 0.5872890515, green: 0.5515661953, blue: 0.5, alpha: 1)
        header.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatRoomMenuCell
        let text = indexData[indexPath.section].items[indexPath.row]
        cell.text = text
        return cell
    }
}

// MARK:- ChatRoomMenuCell
class ChatRoomMenuCell: UITableViewCell {
    
    var text: String! {
        didSet {
            let attText = NSMutableAttributedString(
                string: "# ",
                attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .regular),.foregroundColor: #colorLiteral(red: 0.5872890515, green: 0.5515661953, blue: 0.5, alpha: 1)]
            )
            attText.append(NSAttributedString(
                            string: text,
                            attributes: [
                                .font:UIFont.boldSystemFont(ofSize: 18),
                                .foregroundColor:  UIColor.white
                            ])
            )
            textLabel?.attributedText = attText
        }
    }
    
    // MARK:- Views
    let viewBg: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        view.layer.cornerRadius = 6
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        configureViewBg()
    }
    
    private func configureViewBg() {
        addSubview(viewBg)
        viewBg.fillSuperview(padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        sendSubviewToBack(viewBg)
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewBg.isHidden = !selected
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- ChatHeaderLabel
class ChatHeaderLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 20, dy: 0))
    }
}

struct ChatRoom {
    let title: String
    let items: [String]
    
    static func getChats() -> [ChatRoom] {
        var chats = [ChatRoom]()
        chats.append(ChatRoom(title: "UNREADS", items: ["general","introductions"]))
        chats.append(ChatRoom(title: "CHANNELS", items: ["jobs"]))
        chats.append(ChatRoom(title: "DIRECT MESSAGES", items: ["Brain Voong","Steve Jobs","Tim cock","Barack Obama"]))
        return chats
    }
    
    static func search(query: String) -> [ChatRoom] {
        return getChats().map { ChatRoom(title: $0.title, items: $0.filter(item: query)) }
    }
    
    func filter(item: String)-> [String] {
        return items.filter { $0.lowercased().contains(item.lowercased()) }
    }
}
