//
//  Model.swift
//  Garage Finder
//
//  Created by Johnathan Lee on 5/14/19.
//  Copyright © 2019 Johnathan Lee. All rights reserved.
//
// Holds values of a single listing

import Foundation

class GarageListing{
    var address: String?
    var price: String?
    var email: String?
    var phone: String?
    var image: String?
    
    init(address:String?, price:String?, email:String?, phone:String?, image:String?) {
        self.address = address
        self.price = price
        self.email = email
        self.phone = phone
        self.image = image
    }
}
