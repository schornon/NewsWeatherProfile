//
//  ProfileViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/8/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import Firebase
import RSSelectionMenu

class ProfileViewController: UIViewController, UITabBarControllerDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet var birthdayTextFields: [UITextField]! // tags: dd = 0, mm = 1, yyyy = 2
    
    weak var tabBarViewModel : TabBarViewModel?
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var countryButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    var locationMenu = [RSSelectionMenu<String>]()
    var selectedCountry = [String]()
    var selectedCity = [String]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        if tabBarViewModel == nil {
            weak var tbC = self.tabBarController as? TabBarController
            tabBarViewModel = tbC?.tabBarViewModel
        }
        
        fillingFields()
        
        if tabBarViewModel?.userProfile != nil {
            if tabBarViewModel?.userProfile.confirmed == true {
                self.lockTabItems(false)
            } else {
                self.lockTabItems(true)
            }
        } else {
            self.lockTabItems(true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameTextField.delegate = self
        secondNameTextField.delegate = self
        phoneTextField.delegate = self
        birthdayTextFields[0].delegate = self
        birthdayTextFields[1].delegate = self
        birthdayTextFields[2].delegate = self
        setupMenu()
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        if textFieldsValidation() == false {
            return
        }
        
        let firstName = firstNameTextField.text!
        let secondName = secondNameTextField.text!
        let phone = phoneTextField.text!
        
        let birthday = "\(birthdayTextFields[2].text!)-\(birthdayTextFields[1].text!)-\(birthdayTextFields[0].text!)"
        if validateBirthday(birthday: birthday) == false {
            self.shakeBirthdayFields()
            return
        }
        tabBarViewModel?.userProfile.firstName = firstName
        tabBarViewModel?.userProfile.secondName = secondName
        tabBarViewModel?.userProfile.phoneNumber = phone
        tabBarViewModel?.userProfile.birthday = birthday
        tabBarViewModel?.userProfile.confirmed = true
        
        //updateUserData()
        ProfileViewModel.updateUserData(tabBarViewModel: tabBarViewModel)
        self.lockTabItems(false)
    }
    
    private func validateBirthday(birthday: String) -> Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(birthday)
        guard let date = dateFormatter.date(from: birthday) else { return false }
        if (Date() < date) {
            self.shakeBirthdayFields()
            return false
        }
        return true
    }
    
    private func textFieldsValidation() -> Bool {
        if firstNameTextField.text!.isEmpty {
            firstNameTextField.shake()
            return false
        } else if secondNameTextField.text!.isEmpty {
            secondNameTextField.shake()
            return false
        } else if phoneTextField!.text!.isEmpty {
            phoneTextField.shake()
            return false
        } else if birthdayTextFields![0].text!.isEmpty || birthdayTextFields![0].text!.count < 2 {
            birthdayTextFields[0].shake()
            return false
        } else if birthdayTextFields![1].text!.isEmpty || birthdayTextFields![1].text!.count < 2 {
            birthdayTextFields[1].shake()
            return false
        } else if birthdayTextFields[2].text!.isEmpty || birthdayTextFields![2].text!.count < 4 {
            birthdayTextFields[2].shake()
            return false
        }
        return true
    }
    
    @IBAction func changePasswordButton(_ sender: UIButton) {
        ProfileViewModel.setNew(password: newPasswordTextField.text!) {
            self.newPasswordTextField.shake()
        }
        newPasswordTextField.text! = ""
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "unwindSegueLogOut", sender: self)
    }
    
    private func fillingFields() {
        
        if tabBarViewModel?.userProfile != nil {
            fillFilds()
        }
        self.tabBarViewModel?.myGroup.notify(queue: .main) {
            self.fillFilds()
        }
    }
    
    private func fillFilds() {
        let firstName = self.tabBarViewModel?.userProfile.firstName
        let secondName = self.tabBarViewModel?.userProfile.secondName
        let phoneNumber = self.tabBarViewModel?.userProfile.phoneNumber
        
        self.firstNameTextField.text = firstName
        self.secondNameTextField.text = secondName
        self.phoneTextField.text = phoneNumber
        if self.tabBarViewModel?.userProfile.birthday != "" {
            let birthday = self.tabBarViewModel?.userProfile.birthday.split(separator: "-")
            self.birthdayTextFields[2].text = "\(birthday![0])"
            self.birthdayTextFields[1].text = "\(birthday![1])"
            self.birthdayTextFields[0].text = "\(birthday![2])"
        }
    }
    
    private func lockTabItems(_ action: Bool) {
        
        let tabBarControllerItems = self.tabBarController?.tabBar.items
        ProfileViewModel.lock(tabBarControllerItems: tabBarControllerItems, action)
    }
    
    @IBAction func countryOrCityPressed(_ sender: UIButton) {
        if sender == countryButton {
            self.locationMenu[0].show(style: .alert(title: "Select your country", action: nil, height: nil), from: self)
        } else if sender == cityButton {
            self.locationMenu[1].show(style: .alert(title: "Select your city", action: nil, height: nil), from: self)
        }
    }
    
    
    
    
}
