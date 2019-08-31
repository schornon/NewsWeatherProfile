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
    
    var willShowArticle : NewsArticle?
    
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
            self.tabBarViewModel?.newsNetworkManager?.fetchSourcesData()
        }
        
        tabBarViewModel?.sourcesData.bind { [unowned self] _ in
            
            self.tabBarViewModel?.newsNetworkManager!.fetchData()
        }
        
        
        tabBarViewModel?.newsData.bind { [unowned self] _ in
            self.newsTableView.reloadData()
        }
        
        tabBarViewModel?.pageSize.bind { [unowned self] _ in
            self.tabBarViewModel?.newsNetworkManager!.fetchData()
        }
    }
    
    private func setupViews() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.tableFooterView = UIView()
    }
    
    @IBAction func unwindToNewsVC(segue: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromNewsToNewsDetailsVC" {
            let newsDetailsVC = segue.destination as! NewsDetailsViewController
            
            newsDetailsVC.article = self.willShowArticle
        }
    }
    
}
