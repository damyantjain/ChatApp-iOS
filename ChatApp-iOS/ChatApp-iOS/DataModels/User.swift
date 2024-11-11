//
//  User.swift
//  ChatApp-iOS
//
//  Created by Damyant Jain on 11/7/24.
//
import FirebaseAuth
struct User {
    let email: String
    let name: String
    
    init(email: String, name: String) {
          self.email = email
          self.name = name
      }
      
    init(from firebaseUser: FirebaseAuth.User) {
          self.init(email: firebaseUser.email ?? "", name: firebaseUser.displayName ?? "Unknown")
      }
}
