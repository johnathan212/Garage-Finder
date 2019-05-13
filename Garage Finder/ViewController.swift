//
//  ViewController.swift
//  Garage Finder
//
//  Created by Johnathan Lee on 5/12/19.
//  Copyright © 2019 Johnathan Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func signInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "MainPageSegue", sender: AnyObject.self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

