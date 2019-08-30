//
//  NewsDetailsViewController.swift
//  NewsWeatherProfile
//
//  Created by Serhii CHORNONOH on 8/30/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import SafariServices

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var article : NewsArticle?
    var newsViewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isHidden = true
        
        setupBinding()
        
        setupViews()
    }
    
    private func setupViews() {
        
        if let titleText = article?.title {
            self.titleLabel.text = titleText
        } else {
            titleLabel.isHidden = true
        }

        var mainText = ""
        if let descr = article?.description {
            if let content = article?.content {
                if !content.contains(descr) {
                    mainText = "\(descr)\n\n\(content)"
                } else {
                    mainText = content
                }
            }
        }
        
        mainTextLabel.text = mainText
        
        guard let url = article?.urlToImage else {
            print("guard error let urlImage")
            return
        }
        newsViewModel.fetchNewsImage(urlString: url, clouser: {
            self.imageView.image = self.newsViewModel.image
            self.imageView.isHidden = false
        })
    }
    
    private func setupBinding() {
        
//        newsViewModel.image.bind { [unowned self] in
//
//            self.imageView.image = $0
//            self.imageView.isHidden = false
//        }
    }

    @IBAction func goBackToNewsVC(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToNewsVC", sender: self)
    }

    @IBAction func openInSafariButton(_ sender: UIButton) {
        guard let urlString = article?.url else { return }
        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
