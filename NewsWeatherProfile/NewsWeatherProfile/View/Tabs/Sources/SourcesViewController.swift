//
//  SourcesViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/8/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class SourcesViewController: UIViewController {

    @IBOutlet weak var sourcesTableView: UITableView!
    weak var tabBarViewModel : TabBarViewModel?
    
    var sources = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if tabBarViewModel == nil {
            weak var tbC = self.tabBarController as? TabBarController
            tabBarViewModel = tbC?.tabBarViewModel
        }
        
        setupViews()
    }
    
    private func setupViews() {
        sourcesTableView.delegate = self
        sourcesTableView.dataSource = self
        
        sourcesTableView.tableFooterView = UIView()
    }
    
    

}
