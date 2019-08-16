//
//  ProfileViewModel.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/14/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import FirebaseAuth

class ProfileViewModel {
    
    
    class func setNew(password: String, clouser: @escaping ()->()) {
        Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
            if error != nil {
                clouser()
            }
        })
    }
    
    class func updateUserData(tabBarViewModel: TabBarViewModel?) {
        
        let user = tabBarViewModel!.userProfile
        let uid = tabBarViewModel!.userProfile.uid
        tabBarViewModel!.ref.child("users").child(uid).setValue(["email": user!.email,
                                                                 "confirmed": true,
                                                                 "firstName": user!.firstName,
                                                                 "secondName": user!.secondName,
                                                                 "phoneNumber": user!.phoneNumber,
                                                                 "uid": uid,
                                                                 "birthday": user!.birthday,
                                                                 "country": user!.country,
                                                                 "city": user!.city])
    }
    
    class func lock(tabBarControllerItems: [UITabBarItem]?, _ action: Bool) {
        
        if action == true {
            
            if let arrayOfTabBarItems = tabBarControllerItems as! AnyObject as? NSArray {
                
                let tabBarItemONE = arrayOfTabBarItems[0] as! UITabBarItem
                tabBarItemONE.isEnabled = false
                let tabBarItemTWO = arrayOfTabBarItems[1] as! UITabBarItem
                tabBarItemTWO.isEnabled = false
                let tabBarItemFour = arrayOfTabBarItems[3] as! UITabBarItem
                tabBarItemFour.isEnabled = false
            }
        } else {
            
            if let arrayOfTabBarItems = tabBarControllerItems as! AnyObject as? NSArray {
                
                let tabBarItemONE = arrayOfTabBarItems[0] as! UITabBarItem
                tabBarItemONE.isEnabled = true
                let tabBarItemTWO = arrayOfTabBarItems[1] as! UITabBarItem
                tabBarItemTWO.isEnabled = true
                let tabBarItemFour = arrayOfTabBarItems[3] as! UITabBarItem
                tabBarItemFour.isEnabled = true
            }
        }
        
    }
}
