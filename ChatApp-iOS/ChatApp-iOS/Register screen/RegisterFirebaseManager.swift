//
//  RegisterFirebaseManager.swift
//  ChatApp-iOS
//
//  Created by Esha Chiplunkar on 11/5/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

extension RegisterViewController{
    
    func registerNewAccount(){

        if let name = registerView.nameText.text,
           let email = registerView.emailText.text,
           let password = registerView.passwordText.text{
            
            checkIfEmailExistsInFirestore(email: email) { [weak self] exists in
                if let self = self {
                    if exists {
        
                        self.showAlert("This email is already registered.")
                    } else {
                        //Validations....
                        Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                            if error == nil{
                                //MARK: the user creation is successful...
                                self.setLoading(false)
                                self.setNameOfTheUserInFirebaseAuth(name: name)
                                self.saveUserToFirestore(name: name, email: email)
                                self.notificationCenter.post(name: .registered, object: nil)
                                self.onRegistrationSuccess?()
                                print("registered successfully")
                            } else{
                                //MARK: there is a error creating the user...
                                self.setLoading(false)
                                print(error ?? "Error while creating user")
                            }
                        })
                    }
                }
            }
        }
    }
    
    func saveUserToFirestore(name: String, email: String) {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "name": name,
            "email": email
        ]
            
        db.collection("users").document(email).setData(userData) { error in
            if let error = error {
                print("Error saving user to Firestore: \(error)")
            } else {
                print("User saved successfully to Firestore")
            }
        }
    }
    
    func checkIfEmailExistsInFirestore(email: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(email).getDocument { document, error in
            if let error = error {
                print("Error checking email existence: \(error)")
                completion(false)  // Optionally handle error differently
            } else {
                completion(document?.exists == true)
            }
        }
    }
    
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                print("profile update successful")
                self.dismiss(animated: true)
            }else{
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
