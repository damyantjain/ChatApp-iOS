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
    var dataUsers = [Contact]()
    var filteredDataUsers = [Contact]()
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
        searchSheet.searchBar.delegate = self
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
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else if let documents = querySnapshot?.documents {
                self.dataUsers.removeAll()
                self.filteredDataUsers.removeAll()
                
                for document in documents {
                    if let email = document.data()["email"] as? String,
                       let name = document.data()["name"] as? String {
                        let contact = Contact(name: name, email: email)
                        self.dataUsers.append(contact)
                        
                        if email != self.loggedInUser?.email {
                            self.filteredDataUsers.append(contact)
                        }
                    }
                }
                
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


extension SearchBottomSheetController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredDataUsers = dataUsers.filter { $0.email != loggedInUser?.email }
        } else {
            filteredDataUsers = dataUsers.filter {
                $0.email != loggedInUser?.email && $0.name.contains(searchText)
            }
        }
        searchSheet.tableViewSearchResults.reloadData()
    }
}


