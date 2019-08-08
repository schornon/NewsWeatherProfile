//
//  ProfileViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/8/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet var birthdayTextFields: [UITextField]! // tags: dd = 0, mm = 1, yyyy = 2
    
    weak var tabBarViewModel : TabBarViewModel?
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        if tabBarViewModel == nil {
            weak var tbC = self.tabBarController as? TabBarController
            tabBarViewModel = tbC?.tabBarViewModel
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupFields()
    }
    
    
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
    }
    
    @IBAction func changePasswordButton(_ sender: UIButton) {
    }
    
    
    private func setupFields() {
        
        //print("self.tabBarViewModel?.userProfile.email", self.tabBarViewModel?.userProfile.email)
        
        //
//        let uid = tabBarViewModel!.user.uid
//        tabBarViewModel!.ref.child("users/\(uid)").observeSingleEvent(of: .value) { (snapshot) in
//            let value = snapshot.value as? NSDictionary ?? [:]
//            print(value)
//            print(value["email"])
//            self.firstNameTextField.text = value["email"] as! String
//        }
    }

}
