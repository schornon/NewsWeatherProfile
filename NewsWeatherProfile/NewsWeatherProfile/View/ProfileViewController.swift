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
        
        fillingFields()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    
    @IBAction func confirmButton(_ sender: UIButton) {
        if textFiildsValidation() == false {
            return
        }
        print("here")
        let uid = tabBarViewModel!.userProfile.uid
        
        let firstName = firstNameTextField.text
        let secondName = secondNameTextField.text
        let phone = phoneTextField.text
        
        tabBarViewModel!.ref.child("users/\(uid)/").setValue(["firstName": firstName, "secondName": secondName, "phoneNumber": phone])
    }
    
    private func textFiildsValidation() -> Bool {
        if firstNameTextField.text!.isEmpty {
            firstNameTextField.shake()
            return false
        } else if secondNameTextField.text!.isEmpty {
            secondNameTextField.shake()
            return false
        } else if phoneTextField!.text!.isEmpty {
            phoneTextField.shake()
            return false
        } else if birthdayTextFields![0].text!.isEmpty {
            birthdayTextFields[0].shake()
            return false
        } else if birthdayTextFields![1].text!.isEmpty {
            birthdayTextFields[1].shake()
            return false
        } else if birthdayTextFields[2].text!.isEmpty {
            birthdayTextFields[2].shake()
            return false
        }
        return true
    }
    
    @IBAction func changePasswordButton(_ sender: UIButton) {
    }
    
    
    
    
    private func fillingFields() {
        
        guard let firstName = self.tabBarViewModel?.userProfile.firstName else { return }
        guard let secondName = self.tabBarViewModel?.userProfile.secondName else { return }
        guard let phoneNumber = self.tabBarViewModel?.userProfile.phoneNumber else { return }
        self.firstNameTextField.text = firstName
        self.secondNameTextField.text = secondName
        self.phoneTextField.text = phoneNumber
        //self.birthdayTextFields[0].text = self.tabBarViewModel?.userProfile.birthday
        
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
