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
        allChatsTableView.register(AllChatsTableView.self, forCellReuseIdentifier: "allChats")
        allChatsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(allChatsTableView)
        }
    func initConstraints() {
        NSLayoutConstraint.activate([
            allChatsTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 8),
            allChatsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            allChatsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8),
            allChatsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
