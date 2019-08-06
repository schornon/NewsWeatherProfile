//
//  LoginViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextInFields()
    }

    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!) { [weak self] (user, error) in
            guard let strongSelf = self else { return }
            print("==================\n", user, strongSelf)
            print("error \(error)")
            self!.performSegue(withIdentifier: "segueFromLoginToTabBar", sender: self)
        }
    }
    
    private func setTextInFields() {
        loginTextField.text = "test@gmail.com"
        passwordTextField.text = "test11"
    }
    
    @IBAction func unwindToLoginVC(segue: UIStoryboardSegue) {
        print("unwind from RegistrationViewController")
    }
    
}

