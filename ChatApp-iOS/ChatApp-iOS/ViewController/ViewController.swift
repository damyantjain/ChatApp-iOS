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
    var landView = LandingView();
    
    override func loadView(){
        view=landView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title="My Chats"
        Task {
            await getAllUsers()
        }
    }
    
    func getAllUsers() async{
        do {
          let snapshot = try await db.collection("chats").getDocuments()
          for document in snapshot.documents {
            print("\(document.documentID) => \(document.data())")
          }
        } catch {
          print("Error getting documents: \(error)")
        }
    }

}
