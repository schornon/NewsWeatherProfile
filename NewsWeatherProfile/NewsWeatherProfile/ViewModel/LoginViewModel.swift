//
//  LoginViewModel.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class LoginViewModel {
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func createUser(email: String, password: String, successHandle: @escaping ()->(), errorHandle: @escaping ()->()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                errorHandle()
            } else {
                guard let authResult = authResult else { return }
                let uid = authResult.user.uid
                print(uid)
                
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
                    guard let strongSelf = self else { return }
                    strongSelf.ref.child("users").child(uid).setValue(["email": email,
                                                                       "confirmed": false,
                                                                       "firstName": "",
                                                                       "secondName": "",
                                                                       "phoneNumber": "",
                                                                       "uid": uid,
                                                                       "birthday": "",
                                                                       "country": "Chose country",
                                                                       "city": "Chose city"])
                    successHandle()
                }
            }
            print("authResult:", authResult)
            print("error: ", error)
        }
    }
}
