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
        
        return cell
    }
    
    
}
