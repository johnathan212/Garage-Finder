//
//  DetailsViewController.swift
//  Garage Finder
//
//  Created by Johnathan Lee on 5/15/19.
//  Copyright © 2019 Johnathan Lee. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    var address: String!
    var imageID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addressLabel.text = address
        print("imageID: \(imageID ?? "missing")")
    
    }
}
