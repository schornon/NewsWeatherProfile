//
//  Extension-ProfileViewController+UITextFieldDelegate.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/9/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension ProfileViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField)
        if textField == birthdayTextFields[0] || textField == birthdayTextFields[1] {
            return textFieldOnlyDigitWithLen(textField: textField, range: range, string: string, maxLenght: 2)
        } else if textField == birthdayTextFields[2] {
            return textFieldOnlyDigitWithLen(textField: textField, range: range, string: string, maxLenght: 4)
        } else if textField == phoneTextField {
            return textFieldOnlyDigitWithLen(textField: textField, range: range, string: string, maxLenght: 20)
        }
        return true
    }
    
    private func textFieldOnlyDigitWithLen(textField: UITextField!, range: NSRange, string: String, maxLenght: Int) -> Bool {
       
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        if allowedCharacters.isSuperset(of: characterSet) == false {
            return false
        }
        
        let text = NSString(string: textField.text!)
        let newText = text.replacingCharacters(in: range, with: string)
        return newText.count <= maxLenght
    }
}
