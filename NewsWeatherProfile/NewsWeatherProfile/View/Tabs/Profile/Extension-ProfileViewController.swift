//
//  Extension-ProfileViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/15/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import RSSelectionMenu

/*                          // country - city buttons //
 */

extension ProfileViewController {
    
    func setupMenu() {
        let locationData = LocationData()
        
        let countryMenu = RSSelectionMenu(dataSource: locationData.countries) { (cell, name, indexPath) in
            cell.textLabel!.text = name
        }
        var cityMenu = RSSelectionMenu(dataSource: [String]()) { (cell, name, indexPath) in // cityDataSource
            cell.textLabel!.text = name
        }
        
        countryMenu.setSelectedItems(items: selectedCountry) { (name, index, selected, selectedItems) in
            self.selectedCountry = selectedItems
        }
        
        countryMenu.onDismiss = { [weak self] selectedItems in
            guard
                let strongSelf = self,
                self!.selectedCountry.count > 0
                else { return }
            strongSelf.countryButton.setTitle(strongSelf.selectedCountry[0], for: .normal)
            strongSelf.cityButton.setTitle("Chose city", for: .normal)
            
            cityMenu = RSSelectionMenu(dataSource: locationData.cityData[selectedItems[0]]!) { (cell, name, indexPath) in
                cell.textLabel!.text = name
            }
            
            cityMenu.setSelectedItems(items: self!.selectedCity) { (name, index, selected, selectedItems) in
                self!.selectedCity = selectedItems
            }
            
            cityMenu.onDismiss = { [weak self] selectedItems in
                guard
                    let strongSelf = self,
                    self!.selectedCity.count > 0
                    else { return }
                strongSelf.cityButton.setTitle(strongSelf.selectedCity[0], for: .normal)
            }
            
            strongSelf.locationMenu.popLast()
            strongSelf.locationMenu.append(cityMenu)
        }
        locationMenu.append(countryMenu)
        locationMenu.append(cityMenu)
    }
    
    
    
    
    func shakeBirthdayFields() {
        birthdayTextFields[0].shake()
        birthdayTextFields[1].shake()
        birthdayTextFields[2].shake()
    }
    
}
