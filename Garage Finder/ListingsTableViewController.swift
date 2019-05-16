//
//  ListingsTableViewController.swift
//  Garage Finder
//
//  Created by Johnathan Lee on 5/15/19.
//  Copyright © 2019 Johnathan Lee. All rights reserved.
//

import UIKit
import Firebase

class ListingsTableViewController: UITableViewController {
    @IBOutlet weak var tableview: UITableView!
    var ref: DatabaseReference?
    var imageReference: StorageReference{
        return Storage.storage().reference().child("images")
    }
    //labels
    var addressLabel = ""
    
    var listingData = [GarageListing]()
    var databaseHandle:DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        ref = Database.database().reference().child("listings")
        
        ref?.observe(DataEventType.value, with: { (snapshot) in
            for listings in snapshot.children.allObjects as! [DataSnapshot] {
                let listing = listings.value as? [String: AnyObject]
                let address = listing?["Address"]
                let price = listing?["Price"]
                let email = listing?["Email"]
                let phone = listing?["Phone"]
                let image = listing?["Image"]

                let newListing = GarageListing(address: address as? String, price: price as? Int, email: email as? String, phone: phone as? Int, image: image as? String)

                self.listingData.append(newListing)
            print(snapshot.childrenCount)
            }
            self.tableview.reloadData()
        })
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listingData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableview.dequeueReusableCell(withIdentifier: "listingCell")
//        cell?.textLabel?.text = listingData[indexPath.row]
//        return cell!
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as! ListingCell
        
        let listing: GarageListing
        listing = listingData[indexPath.row]
        
//        let databaseImageRef = imageReference.child(listing.image!)
//
//        let downloadTask = databaseImageRef.getData(maxSize: 1024 * 1024) { (data, error) in
//            if let data = data {
//                let image = UIImage(data: data)
//
//                cell.cellImageView.image = image
//                cell.cellImageView.contentMode = .s
//            }
//        }
//        downloadTask.resume()
//
        print(listing.address!)

        cell.textLabel?.text = listing.address
        
        print(listing.address ?? "broken")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressLabel = listingData[indexPath.row].address!
        performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsViewController
        vc.address = self.addressLabel
        
    }
}
