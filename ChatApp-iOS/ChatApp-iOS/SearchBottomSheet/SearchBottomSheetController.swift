//
//  SearchBottomSheetController.swift
//  BottomSheetViewDemo
//
//  Created by Sakib Miazi on 6/13/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SearchBottomSheetController: UIViewController {
    

    var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()
    var dataUsers = [Contact]()
    var loggedInUser: User?
    
    var navigationController1: UINavigationController?
    
    let searchSheet = SearchBottomSheetView()
    
    let notificationCenter = NotificationCenter.default
    
    var namesDatabase = [String]()
    
    var namesForTableView = [String]()
    
    override func loadView() {
        view = searchSheet
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        namesDatabase.sort()
        
        searchSheet.tableViewSearchResults.delegate = self
        searchSheet.tableViewSearchResults.dataSource = self
        
        searchSheet.searchBar.delegate = self
        
        namesForTableView = namesDatabase
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authStateListenerHandle =   Auth.auth().addStateDidChangeListener { auth, user in
                if user == nil {
                    // Handle the case where the user is not logged in...
                    print("User not logged in!")
                } else {
                    self.db.collection("users").getDocuments { (querySnapshot, error) in
                        if let error = error {
                            print("Error fetching documents: \(error)")
                        } else if let documents = querySnapshot?.documents {
                            self.namesDatabase.removeAll() // Clear existing data

                            for document in documents {
                                if let name = document.data()["name"] as? String {
                                    self.namesDatabase.append(name)
                                }
                                if let email = document.data()["email"] as? String,
                                        let name = document.data()["name"] as? String {
                                    let contact = Contact(name: name, email: email)
                                        self.dataUsers.append(contact)
                                 }
                            }
                            
                            // Sort and reload the table view with the updated data
                            self.namesDatabase.sort()
                            self.namesForTableView = self.namesDatabase
                            self.searchSheet.tableViewSearchResults.reloadData()
                        }
                    }
                }
            }
            
    }

    
}

//MARK: adopting Table View protocols...
extension SearchBottomSheetController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Configs.searchTableViewID, for: indexPath) as! SearchTableCell
        
        cell.labelTitle.text = namesForTableView[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = dataUsers[indexPath.row]
        
        let chatViewController = ChatViewController(
            contact: User(email: chat.email, name: chat.name),
            loggedInUser: self.loggedInUser!
        )
        print("Test in did select" + chat.email + " " + chat.name)
        navigationController1?.pushViewController(chatViewController, animated: true)
        
        self.dismiss(animated: true)
    }
}

//MARK: adopting the search bar protocol...
extension SearchBottomSheetController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            namesForTableView = namesDatabase
        }else{
            self.namesForTableView.removeAll()

            for name in namesDatabase{
                if name.contains(searchText){
                    self.namesForTableView.append(name)
                }
            }
        }
        self.searchSheet.tableViewSearchResults.reloadData()
    }
}
