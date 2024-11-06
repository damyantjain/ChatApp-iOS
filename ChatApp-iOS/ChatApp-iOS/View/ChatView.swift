//
//  ChatView.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/6/24.
//

import UIKit

class ChatView: UIView {

    var chatTableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpChatTableView()
        initConstraints()
    }

    func setUpChatTableView() {
        chatTableView = UITableView()
        chatTableView.register(
            ChatTableViewCell.self, forCellReuseIdentifier: "chats")
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(chatTableView)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([

            //Chat Table View
            chatTableView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            chatTableView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            chatTableView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            chatTableView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
