//
//  ViewController.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/4/24.
//

import CryptoKit
import FirebaseAuth
import FirebaseFirestore
import UIKit

class ViewController: UIViewController {

    let db = Firestore.firestore()
    var landView = LandingView()
    var loggedInUser = User(email: "", name: "")

    var chats = [ChatDetails]()

    override func loadView() {
        view = landView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Chats"

        _ = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if user != nil {
                self?.loadChatsForLoggedInUser()
            } else {
                self?.showLoginScreen()
            }
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped)
        )

        let logoutAction = UIAction(title: "Logout") { _ in
            self.logout()
        }

        let menu = UIMenu(title: "Select type", children: [logoutAction])

        let userMenu = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: nil,
            action: nil
        )
        userMenu.tintColor = .black
        navigationItem.leftBarButtonItem = userMenu

        navigationItem.leftBarButtonItem?.menu = menu
        landView.allChatsTableView.delegate = self
        landView.allChatsTableView.dataSource = self
        landView.allChatsTableView.separatorStyle = .singleLine
    }

    func getAllChats() async {
        do {
            print("current logged in user:", loggedInUser.email)
            let snapshot = try await db.collection("users").document(
                loggedInUser.email
            ).collection("chats").getDocuments()
            for document in snapshot.documents {
                let data = document.data()
                if let lastMessage = data["lastMessage"] as? String,
                    let chatWith = data["chatWith"] as? String,
                    let timestamp = data["timestamp"] as? Timestamp,
                    let chatWithEmail = data["chatWithEmail"] as? String
                {
                    let chat = ChatDetails(
                        lastMessage: lastMessage, chatWith: chatWith,
                        timestamp: timestamp.dateValue(),
                        chatWithEmail: chatWithEmail)
                    chats.append(chat)
                    chats.sort { $0.timestamp > $1.timestamp }
                    self.landView.allChatsTableView.reloadData()
                }
            }

        } catch {
            print("Error getting documents: \(error)")
        }
    }
    @objc func onAddBarButtonTapped() {

    }
    func logout() {
        let logoutAlert = UIAlertController(
            title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(
            UIAlertAction(
                title: "Yes, log out!", style: .default,
                handler: { (_) in
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        print("Error occured!")
                    }
                })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(logoutAlert, animated: true)
    }

    func showLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen

        loginVC.onLoginSuccess = { [weak self] in
            self?.dismiss(animated: true) {
                self?.loadChatsForLoggedInUser()
            }
        }

        present(loginVC, animated: true)
    }

    func loadChatsForLoggedInUser() {
        if let user = Auth.auth().currentUser, let email = user.email,
            !email.isEmpty
        {
            loggedInUser = User(
                email: email, name: user.displayName ?? "Unknown")
            Task {
                await getAllChats()
            }
        } else {
            print("Error: Logged in user email is empty.")
            showLoginScreen()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "allChats", for: indexPath)
            as! AllChatsTableView
        cell.selectionStyle = .none
        cell.senderNameLabel.text = chats[indexPath.row].chatWith
        cell.messageTextLabel.text = chats[indexPath.row].lastMessage
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        cell.timestampLabel.text = dateFormatter.string(
            from: chats[indexPath.row].timestamp)
        return cell
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        let chat = chats[indexPath.row]
        let cv = ChatViewController(
            contact: User(email: chat.chatWithEmail, name: chat.chatWith),
            loggedInUser: loggedInUser)
        navigationController?.pushViewController(
            cv, animated: true)
    }

}
