//
//  RegistrationViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/6/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func signUpButton(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let confPass = confirmPasswordTextField.text else { return }
        if textFieldsValidation(email, password, confPass) {
            print("validation ok")
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    self.emailTextField.shake()
                } else {
                    guard let authResult = authResult else { return }
                    print(authResult.user.uid)
                }
                print("authResult:", authResult)
                print("error: ", error)
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


extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
