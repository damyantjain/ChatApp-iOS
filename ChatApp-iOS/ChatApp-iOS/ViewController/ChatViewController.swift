//
//  ChatViewController.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/6/24.
//

import CryptoKit
import FirebaseFirestore
import UIKit

class ChatViewController: UIViewController {

    let db = Firestore.firestore()
    let loggedInUser = User(email: "peter@mail.com", name: "Peter")
    let chatView = ChatView()
    let contact: User
    var chatId: String?
    var messages: [Message] = []
    var messageListener: ListenerRegistration?

    init(contact: User) {
        self.contact = contact
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

        chatView.sendButton.addTarget(
            self, action: #selector(sendMessage), for: .touchUpInside)

        chatView.chatTableView.separatorStyle = .none
        title = contact.name
        chatId = formChatId()

        chatView.chatTableView.delegate = self
        chatView.chatTableView.dataSource = self

        fetchRealTimeMessage()
    }

    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }

    @objc func sendMessage() {
        Task { await sendMessageAsync() }
    }

    func sendMessageAsync() async {
        do {
            if let text = chatView.chatTextField.text, !text.isEmpty {
                try await db.collection("chats").document(chatId!).collection(
                    "messages"
                ).addDocument(data: [
                    "text": text,
                    "sender_Id": loggedInUser.email,
                    "time_stamp": Timestamp(date: Date()),
                ])
                chatView.chatTextField.text = ""
            }
        } catch {
            print("Error writing document: \(error)")
        }
    }

    func fetchRealTimeMessage() {
        guard let chatId = chatId else { return }

        let docRef = db.collection("chats").document(chatId).collection(
            "messages"
        ).order(by: "time_stamp", descending: false)

        messageListener = docRef.addSnapshotListener {
            [weak self] snapshot, error in
            guard let self = self else { return }

            if let error = error {
                print("Error listening for messages: \(error)")
                return
            }

            for change in snapshot?.documentChanges ?? [] {
                if change.type == .added {
                    let data = change.document.data()
                    if let text = data["text"] as? String,
                        let senderId = data["sender_Id"] as? String,
                        let timestamp = data["time_stamp"] as? Timestamp
                    {
                        let senderName = getSenderName(senderId)
                        let newMessage = Message(
                            text: text, senderId: senderId,
                            timestamp: timestamp.dateValue(),
                            senderName: senderName)
                        self.messages.append(newMessage)
                        let newIndexPath = IndexPath(
                            row: self.messages.count - 1, section: 0)
                        self.chatView.chatTableView.insertRows(
                            at: [newIndexPath], with: .automatic)
                        self.chatView.chatTableView.scrollToRow(
                            at: newIndexPath, at: .bottom, animated: false)
                    }
                }
            }
        }
    }

    func getSenderName(_ senderId: String) -> String {
        if senderId.lowercased() == loggedInUser.email.lowercased() {
            return loggedInUser.name
        } else {
            return contact.name
        }
    }

    private func scrollToLastMessage() {
        let lastRowIndex = messages.count - 1
        if lastRowIndex >= 0 {
            let lastIndexPath = IndexPath(row: lastRowIndex, section: 0)
            chatView.chatTableView.scrollToRow(
                at: lastIndexPath, at: .none, animated: false)
        }
    }

    func formChatId() -> String {
        let loggedInUserId = loggedInUser.email.lowercased()
        let otherUserId = contact.email.lowercased()
        let combinedId =
            loggedInUserId < otherUserId
            ? "\(loggedInUserId)\(otherUserId)"
            : "\(otherUserId)\(loggedInUserId)"
        let data = Data(combinedId.utf8)
        let hashed = SHA256.hash(data: data)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }
            .joined()

        return hashString
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        messageListener?.remove()
        messageListener = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
