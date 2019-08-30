//
//  NewsDetailsViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/30/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func goBackToNewsVC(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToNewsVC", sender: self)
    }

}
