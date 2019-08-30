//
//  NewsViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/8/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var tabBarViewModel : TabBarViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarViewModel?.newsNetworkManager.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tabBarViewModel == nil {
            weak var tbC = self.tabBarController as? TabBarController
            tabBarViewModel = tbC?.tabBarViewModel
            if tabBarViewModel?.userProfile != nil {
                print("if tabBarViewModel?.userProfile != nil")
            }
            self.tabBarViewModel?.myGroup.notify(queue: .main) {
                print("self.tabBarViewModel?.myGroup.notify(queue: .main)")
            }
        }

        /*
         if tabBarViewModel?.userProfile != nil {
         fillFilds()
         }
         self.tabBarViewModel?.myGroup.notify(queue: .main) {
         self.fillFilds()
         }
 */
    }
    

    

}
