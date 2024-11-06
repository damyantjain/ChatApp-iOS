//
//  ChatViewController.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/6/24.
//

import UIKit

class ChatViewController: UIViewController {
    
    let chatView = ChatView()
    
    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
