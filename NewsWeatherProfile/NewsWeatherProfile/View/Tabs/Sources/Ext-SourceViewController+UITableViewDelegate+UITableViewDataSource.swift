//
//  Ext-SourceViewController+UITableViewDelegate+UITableViewDataSource.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/30/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension SourcesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabBarViewModel?.sourcesData.value.sources.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sourcesTableViewCell", for: indexPath) as! SourcesTableViewCell
        
        let name = tabBarViewModel?.sourcesData.value.sources[indexPath.row].name
        cell.nameLabel.text = name
        
        if let currSource = tabBarViewModel?.sourcesData.value.sources[indexPath.row] {
            if let strongFavorite = tabBarViewModel?.sourcesData.value.favoriteSources {
                if strongFavorite.contains(where: { $0.name == currSource.name
                }) {
                    cell.favoriteImageView.image = UIImage(named: "Favorite1")
                } else {
                    cell.favoriteImageView.image = UIImage(named: "Favorite0")
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tabBarViewModel?.pageSize.value != 10 {
           tabBarViewModel?.pageSize.value = 10
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! SourcesTableViewCell
        
        guard let selectedSource = tabBarViewModel?.sourcesData.value.sources[indexPath.row] else { return }
        guard let strongFavorite = tabBarViewModel?.sourcesData.value.favoriteSources else { return }
        
        if strongFavorite.contains(where: { $0.name == selectedSource.name
        }) {
            print("contains")
            tabBarViewModel?.sourcesData.value.favoriteSources?.removeAll(where: { $0.name == selectedSource.name })
            cell.favoriteImageView.image = UIImage(named: "Favorite0")
        } else {
            print("dont contains")
            tabBarViewModel?.sourcesData.value.favoriteSources?.append(selectedSource)
            cell.favoriteImageView.image = UIImage(named: "Favorite1")
        }
    }
    
    
    
}
