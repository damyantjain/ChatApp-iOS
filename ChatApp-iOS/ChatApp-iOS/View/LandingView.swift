//
//  LandingView.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/5/24.
//

import UIKit

class LandingView: UIView {

    var allChatsTableView: UITableView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpChatTableView()
        initConstraints()
    }

    func setUpChatTableView() {
        allChatsTableView = UITableView()
        allChatsTableView.separatorInset = .zero
        allChatsTableView.layoutMargins = .zero
        allChatsTableView.register(
            AllChatsTableView.self, forCellReuseIdentifier: "allChats")
        allChatsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(allChatsTableView)
    }
    func initConstraints() {
        NSLayoutConstraint.activate([
            allChatsTableView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor),
            allChatsTableView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            allChatsTableView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            allChatsTableView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
