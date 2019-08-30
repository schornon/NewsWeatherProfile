//
//  NewsViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/8/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var tabBarViewModel : TabBarViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarViewModel?.newsNetworkManager!.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        if tabBarViewModel == nil {
            weak var tbC = self.tabBarController as? TabBarController
            tabBarViewModel = tbC?.tabBarViewModel
        }
        setupBinding()
    }
    
    private func setupBinding() {
        
        tabBarViewModel?.userProfile.bind { [unowned self] _ in
            
            self.tabBarViewModel?.newsNetworkManager!.fetchData()
            
        }
        
        tabBarViewModel?.newsData.bind { [unowned self] _ in
            self.newsTableView.reloadData()
        }
    }
    
    private func setupViews() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.tableFooterView = UIView()
    }
    
    @IBAction func unwindToNewsVC(segue: UIStoryboardSegue) {}
    

}
