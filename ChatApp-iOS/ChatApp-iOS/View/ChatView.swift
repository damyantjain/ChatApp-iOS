//
//  ChatView.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/6/24.
//

import UIKit

class ChatView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        initConstraints()
    }

    func initConstraints() {

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
