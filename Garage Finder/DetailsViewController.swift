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
    
    var address: String!
    var imageID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imagePath = "images/" + imageID
        var imageReference: StorageReference{
            return Storage.storage().reference().child(imagePath)
        }

        addressLabel.text = address
        print("imageID: \(imageID ?? "missing")")
//        let databaseImageRef = imageReference.child(imageID)
        
//            let downloadTask = databaseImageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//                if let data = data {
//                    let newImage = UIImage(data: data)
//                    //self.image.image = newImage
//                }
//            }
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
