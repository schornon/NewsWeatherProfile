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
    
    let myGroup = DispatchGroup()
    
    //var userProfile : UserProfile!
    var userProfile : Box<UserProfile> = Box(UserProfile())
    
    var newsNetworkManager : NewsNetworkManager?
    var newsData : Box<NewsData> = Box(NewsData())
    
    init(clouser: @escaping ()->()) {
        myGroup.enter()
        self.newsNetworkManager = NewsNetworkManager(viewModel: self)
        
        ref = Database.database().reference()
        
        print("curr user: \(user.uid)")
        
        ref.child("users").observeSingleEvent(of: .childAdded) { (snapshot) in
            
            self.ref.child("users/\(self.user.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary ?? [:]
                print(value)
                self.userProfile.value = self.userData(value: value)
                let confirmed = value["confirmed"] as? Bool
                if confirmed == false {
                    print("false")
                    clouser()
                    self.myGroup.leave()
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
        let country = value["country"] ?? "Chose country"
        let city = value["city"] ?? "Chose city"
        
        return UserProfile(birthday: birthday as! String,
                           firstName: firstName as! String,
                           secondName: secondName as! String,
                           phoneNumber: phoneNumber as! String,
                           uid: uid as! String,
                           email: email as! String,
                           confirmed: confirmed as! Bool,
                           country: country as! String,
                           city: city as! String)
    }
    
}
