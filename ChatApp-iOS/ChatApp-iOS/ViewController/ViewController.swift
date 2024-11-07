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
    let loggedInUser = "peter"
    var chats = [ChatDetails]()
    
    override func loadView(){
        view=landView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="My Chats"
        landView.allChatsTableView.delegate = self
        landView.allChatsTableView.dataSource = self
        landView.allChatsTableView.separatorStyle = .none
        Task {
            await getAllChats()
        }
        
        
        
        
        func getAllChats() async{
            do {
                let snapshot = try await db.collection("users").document("Bi3jIBWkqcdXeQ2xjykg").collection("chats").getDocuments()
                for document in snapshot.documents {
                    let data = document.data()
                    if let lastMessage = data["lastMessage"] as? String,
                       let chatWith = data["chatWith"] as? String,
                       let timestamp = data["timestamp"] as? Timestamp 
                    {
                        let chat = ChatDetails(lastMessage: lastMessage, chatWith: chatWith, timestamp: timestamp.dateValue())
                       chats.append(chat)
                        self.landView.allChatsTableView.reloadData()
                    }
                }
                
                
                
            } catch {
                print("Error getting documents: \(error)")
            }
        }
        
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allChats", for: indexPath) as! AllChatsTableView
        cell.selectionStyle = .none
        tableView.separatorStyle = .none
        cell.senderNameLabel.text = chats[indexPath.row].chatWith
        cell.messageTextLabel.text=chats[indexPath.row].lastMessage
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        cell.timestampLabel.text = dateFormatter.string(from: chats[indexPath.row].timestamp)
        
//      let chat = chats[indexPath.row]
//      cell.senderNameLabel.text = chat.sender
//      cell.messageTextLabel.text = chat.lastMessage // if you want to display the last message as well
        return cell
    }

}
