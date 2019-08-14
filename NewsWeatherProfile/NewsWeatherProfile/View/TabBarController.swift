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
        print("user profile in tabBarController : \(tabBarViewModel?.userProfile)")
    }
    
    private func setupObserve() {
        

    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("should")
        return true
    }
    
}
