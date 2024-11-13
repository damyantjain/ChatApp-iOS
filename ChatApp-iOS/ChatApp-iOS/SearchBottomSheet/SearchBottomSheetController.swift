//
//  SearchBottomSheetController.swift
//
// Created by Gautam Raju on 11/10/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SearchBottomSheetController: UIViewController {
    
    var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()
    var dataUsers = [User]()
    var filteredDataUsers = [User]()
    var loggedInUser: User?
    
    var navigationController1: UINavigationController?
    
    let searchSheet = SearchBottomSheetView()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = searchSheet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchSheet.tableViewSearchResults.delegate = self
        searchSheet.tableViewSearchResults.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("User not logged in!")
            } else {
                self.loggedInUser = User(from: user!)
                self.fetchUsers()
            }
        }
    }
    
    func fetchUsers() {
        
        guard let loggedInUserEmail = loggedInUser?.email else {
              print("Logged-in user not set. Aborting fetch.")
              return
          }
          
        
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else if let documents = querySnapshot?.documents {
                self.dataUsers.removeAll()
                self.filteredDataUsers.removeAll()
                
                for document in documents {
                    if let email = document.data()["email"] as? String,
                       let name = document.data()["name"] as? String {
                        let user = User(email: email, name: name)
                        self.dataUsers.append(user) 
                    }
                }
                
                self.filteredDataUsers = self.dataUsers.filter { $0.name != self.loggedInUser?.name }
                self.searchSheet.tableViewSearchResults.reloadData()
            }
        }
    }

}


extension SearchBottomSheetController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Configs.searchTableViewID, for: indexPath) as! SearchTableCell
        
        cell.labelTitle.text = filteredDataUsers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = filteredDataUsers[indexPath.row]
        
        let chatViewController = ChatViewController(
            contact: User(email: chat.email, name: chat.name),
            loggedInUser: self.loggedInUser!
        )
        print("Test in did select" + chat.email + " " + chat.name)
        navigationController1?.pushViewController(chatViewController, animated: true)
        
        self.dismiss(animated: true)
    }
}




