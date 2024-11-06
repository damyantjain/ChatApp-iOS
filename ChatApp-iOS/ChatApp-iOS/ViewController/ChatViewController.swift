//
//  ChatViewController.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/6/24.
//

import FirebaseFirestore
import UIKit

class ChatViewController: UIViewController {

    let db = Firestore.firestore()

    let loggedInUser = "peter"
    let chatView = ChatView()
    let id: String
    var messages: [Message] = []

    init(id: String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = chatView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)

        chatView.chatTableView.separatorStyle = .none
        title = id
        Task { await getChat() }

        chatView.chatTableView.delegate = self
        chatView.chatTableView.dataSource = self
    }

    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }

    func getChat() async {
        let chatId = formChatId()
        let docRef = db.collection("chats").document(chatId).collection(
            "messages"
        ).order(by: "time_stamp", descending: false)

        do {
            let snapshot = try await docRef.getDocuments()
            for document in snapshot.documents {
                let data = document.data()
                if let text = data["text"] as? String,
                    let senderId = data["sender_Id"] as? String,
                    let timestamp = data["time_stamp"] as? Timestamp
                {
                    messages.append(
                        Message(
                            text: text, senderId: senderId,
                            timestamp: timestamp.dateValue()))
                }
            }
            self.chatView.chatTableView.reloadData()
        } catch {
            print("Error getting document: \(error)")
        }
    }

    func formChatId() -> String {
        let loggedInUserId = loggedInUser.lowercased()
        let otherUserId = id.lowercased()
        return loggedInUserId < otherUserId
            ? "\(loggedInUserId)_\(otherUserId)"
            : "\(otherUserId)_\(loggedInUserId)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
