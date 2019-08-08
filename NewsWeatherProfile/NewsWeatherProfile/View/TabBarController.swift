//
//  TabBarController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/6/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class TabBarController: UITabBarController {

    var tabBarViewModel : TabBarViewModel?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarViewModel = TabBarViewModel(clouser: { self.selectedIndex = 2 } )
        //setupObserve()
    }
    
    private func setupObserve() {
        
//        self.tabBarViewModel!.ref.child("users/\(self.tabBarViewModel!.user.uid)/confirmed").observe(.childChanged) { (snapshot) in
//            let value = snapshot.value as? NSDictionary ?? [:]
//            let confirmed = value["confirmed"] as? Bool
//            if confirmed == false {
//                print("changed confirmed")
//            }
//        }
    }

}
