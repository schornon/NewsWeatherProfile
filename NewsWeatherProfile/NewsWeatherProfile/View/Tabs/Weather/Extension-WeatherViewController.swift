//
//  Extension-WeatherViewController.swift
//  WeatherApp2-MVVM-singleView
//
//  Created by Serhii CHORNONOH on 7/29/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension WeatherViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()

        let greyColor = UIColor(red:0.81, green:0.81, blue:0.81, alpha:1.0)
        let lightGreyColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
        
        self.activityView.alpha = 0
        self.activityView.color = lightGreyColor
        for label in weatherLabels {
            label.textColor = lightGreyColor
        }
        
        setupTextField(color: greyColor)
        
        backgroundView.layer.addSublayer(gradientLayer)
        setBlueGradientBackground()
        
        showWeatherInUserProfileLocation()
    }
    
    private func showWeatherInUserProfileLocation() {
        
        if tabBarViewModel == nil {
            weak var tbC = self.tabBarController as? TabBarController
            tabBarViewModel = tbC?.tabBarViewModel
        }
        let userLocation = tabBarViewModel!.userProfile.value.city
        print("userLocation: '\(userLocation)'")
        viewModel?.fetchMetadata(request: userLocation)
    }
    
    func setupTextField(color: UIColor) {
        textField.layer.borderColor = color.cgColor
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1.0
        textField.attributedPlaceholder = NSAttributedString(string: "Weather in ?", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func setBlueGradientBackground() {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func setGreyGradientBackground(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
