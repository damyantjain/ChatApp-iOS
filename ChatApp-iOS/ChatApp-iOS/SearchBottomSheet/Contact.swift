//
//  Contact.swift
//  ChatApp-iOS
//
//  Created by Gautam Raju on 11/10/24.
//


import Foundation

struct Contact: Codable{
//    @DocumentID var id: String?
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
        
    }
}
