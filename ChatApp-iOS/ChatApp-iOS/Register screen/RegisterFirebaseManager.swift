//
//  RegisterFirebaseManager.swift
//  ChatApp-iOS
//
//  Created by Esha Chiplunkar on 11/5/24.
//

import Foundation
import FirebaseAuth

extension RegisterViewController{
    
    func registerNewAccount(){
        //MARK: create a Firebase user with email and password...
        if let name = registerView.nameText.text,
           let email = registerView.emailText.text,
           let password = registerView.passwordText.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
                if error == nil{
                    //MARK: the user creation is successful...
                    self.setLoading(false)
                    self.setNameOfTheUserInFirebaseAuth(name: name)
                    self.notificationCenter.post(name: .registered, object: nil)
                }else{
                    //MARK: there is a error creating the user...
                    self.setLoading(false)
                    print(error ?? "Error while creating user")
                }
            })
        }
    }
    
    //MARK: We set the name of the user after we create the account...
    func setNameOfTheUserInFirebaseAuth(name: String){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.commitChanges(completion: {(error) in
            if error == nil{
                //MARK: the profile update is successful...
                print("profile update successful")
                self.dismiss(animated: true)
            }else{
                //MARK: there was an error updating the profile...
                print("Error occured: \(String(describing: error))")
            }
        })
    }
}
