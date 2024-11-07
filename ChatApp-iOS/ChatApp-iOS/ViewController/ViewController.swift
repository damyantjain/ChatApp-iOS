//
//  ViewController.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/4/24.
//

import FirebaseFirestore
import UIKit

class ViewController: UIViewController {

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped))
        Task {
            //await addUser()
            //await getAllUsers()
        }
    }

    @objc func onAddBarButtonTapped() {
        var contact = User(
            email: "sarah@mail.com", name: "Sarah",
            documentID: "Z5omu7rwA4SfqFEoNF3W")
        navigationController?.pushViewController(
            ChatViewController(contact: contact), animated: true)
    }

    func getAllUsers() async {
        do {
            let snapshot = try await db.collection("users").getDocuments()
            for document in snapshot.documents {
                print("\(document.documentID) => \(document.data())")
            }
        } catch {
            print("Error getting documents: \(error)")
        }
    }

    func addUser() async {
        do {
            let ref = try await db.collection("users").addDocument(data: [
                "first": "Ada",
                "last": "Lovelace",
                "born": 1815,
            ])
            print("Document added with ID: \(ref.documentID)")
        } catch {
            print("Error adding document: \(error)")
        }
    }

}
