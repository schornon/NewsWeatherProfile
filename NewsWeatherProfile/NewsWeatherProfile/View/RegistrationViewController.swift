//
//  RegistrationViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/6/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var successLabel: UILabel!
    
    //var ref: DatabaseReference!
    var loginViewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ref = Database.database().reference()
    }

    @IBAction func signUpButton(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let confPass = confirmPasswordTextField.text else { return }
        if textFieldsValidation(email, password, confPass) {
            print("validation ok")
            loginViewModel.createUser(email: email, password: password, successHandle: {
                self.performSegue(withIdentifier: "segueFromRegistrationToTabBar", sender: self)
            }) {
                self.emailTextField.shake()
            }
        }
    }
    
    private func textFieldsValidation(_ email: String, _ password: String, _ confPass: String ) -> Bool {
        var isValid = true
        if email.isEmpty {
            emailTextField.shake()
            isValid = false
        } else if password.isEmpty || password.count < 6 {
            passwordTextField.shake()
            isValid = false
        } else if confPass.isEmpty {
            confirmPasswordTextField.shake()
            isValid = false
        } else if password != confPass {
            passwordTextField.shake()
            confirmPasswordTextField.shake()
            isValid = false
        }
        return isValid
    }
    
    
    @IBAction func backBarButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "unwindSegueToLoginVC", sender: self)
    }
    
    
}
