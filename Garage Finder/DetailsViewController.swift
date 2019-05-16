//
//  DetailsViewController.swift
//  Garage Finder
//
//  Created by Johnathan Lee on 5/15/19.
//  Copyright © 2019 Johnathan Lee. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var address: String!
    var imageID: String!
    var price: String!
    var email: String!
    var phone: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imagePath = "images/" + imageID
        var imageReference: StorageReference{
            return Storage.storage().reference().child(imagePath)
        }

        addressLabel.text = address
        priceLabel.text = String(price)
        emailLabel.text = email
        phoneLabel.text = String(phone)
        print("imageID: \(imageID ?? "missing")")

        print(imageReference)
        
        
        imageReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("image error \(error)")
            } else {
                let image = UIImage(data: data!)
                self.image.image = image
            }
        }
        
    }
}
