//
//  TabBarViewModel.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/7/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class TabBarViewModel {
    
    var ref: DatabaseReference!
    
    let user = Auth.auth().currentUser!
    
    //var confirmed : Box<Bool> = Box(false)
    //var userProfile : Box<UserProfile> = Box(UserProfile())
    
    
    var userProfile : UserProfile!
    
    init(clouser: @escaping ()->()) {
        ref = Database.database().reference()
        
        print("curr user: \(user.uid)")
        
        ref.child("users").observeSingleEvent(of: .childAdded) { (snapshot) in
            
            self.ref.child("users/\(self.user.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary ?? [:]
                //print(value)
                self.userProfile = self.userData(value: value)
                let confirmed = value["confirmed"] as? Bool
                if confirmed == false {
                    print("false")
                    clouser()
                }
            })
        }

    }
    
    private func userData(value: NSDictionary) -> UserProfile {
    
        let email = value["email"] ?? ""
        let confirmed = value["confirmed"] ?? false
        let firstName = value["firstName"] ?? ""
        let secondName = value["secondName"] ?? ""
        let phoneNumber = value["phoneNumber"] ?? ""
        let uid = value["uid"] ?? ""
        let birthday = value["birthday"] ?? ""
        
        return UserProfile(birthday: birthday as! String,
                           firstName: firstName as! String,
                           secondName: secondName as! String,
                           phoneNumber: phoneNumber as! String,
                           uid: uid as! String,
                           email: email as! String,
                           confirmed: confirmed as! Bool)
    }
    
}
