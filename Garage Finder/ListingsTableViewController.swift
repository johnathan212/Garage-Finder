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
    
//    var listingData = [String]()
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

                let newListing = GarageListing(address: address as? String, price: price as? Int, email: email as? String, phone: phone as? Int)

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
        
        print(listing.address!)
//        cell.addressLabel!.textLabel?.text = listing.address
        cell.textLabel?.text = listing.address
        print(listing.address ?? "broken")
        return cell
    }
}
