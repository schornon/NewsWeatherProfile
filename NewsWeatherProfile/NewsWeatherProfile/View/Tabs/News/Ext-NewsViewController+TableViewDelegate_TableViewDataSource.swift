//
//  Ext-NewsViewController+TableViewDelegate_TableViewDataSource.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/30/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabBarViewModel?.newsData.value.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath) as! NewsTableViewCell
        
        cell.titleLabel.text = tabBarViewModel?.newsData.value.articles[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.willShowArticle = tabBarViewModel?.newsData.value.articles[indexPath.row]
        performSegue(withIdentifier: "segueFromNewsToNewsDetailsVC", sender: self)
    }
    
}
