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

    //labels for segue passing
    var addressLabel = ""
    var imageID = ""
    var priceLabel = ""
    var emailLabel = ""
    var phoneLabel = ""
    
    var listingData = [GarageListing]()
    var databaseHandle:DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.rowHeight = 100
        
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

                let newListing = GarageListing(address: address as? String, price: price as? String, email: email as? String, phone: phone as? String, image: image as? String)

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
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "listingCell", for: indexPath) as! ListingCell
        
        let listing: GarageListing
        listing = listingData[indexPath.row]
        

        cell.textLabel?.text = listing.address
        cell.textLabel?.font = cell.textLabel?.font.withSize(20)
        
        print(listing.address ?? "broken")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressLabel = listingData[indexPath.row].address!
        imageID = listingData[indexPath.row].image!
        priceLabel = String(listingData[indexPath.row].price!)
        emailLabel = listingData[indexPath.row].email!
        phoneLabel = String(listingData[indexPath.row].phone!)
        performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "details"){
            let vc = segue.destination as! DetailsViewController
            vc.address = self.addressLabel
            vc.imageID = self.imageID
            vc.price = self.priceLabel
            vc.email = self.emailLabel
            vc.phone = self.phoneLabel
        }
    }
}
