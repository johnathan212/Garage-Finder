//
//  DetailsViewController.swift
//  Garage Finder
//
//  Created by Johnathan Lee on 5/15/19.
//  Copyright © 2019 Johnathan Lee. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let image = UIImage(named: "default.png")
        imageView.image = image

    
    }
}
