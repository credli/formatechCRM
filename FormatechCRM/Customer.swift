//
//  Customer.swift
//  FormatechCRM
//
//  Created by Nicholas Credli on 3/15/16.
//  Copyright © 2016 Novium Collective SARL. All rights reserved.
//

class Customer {
    var id: String
    var name: String
    var balance: Double
    var latitude: Double
    var longitude: Double
    
    init(id theid: String, name: String, balance: Double, latitude: Double, longitude: Double) {
        self.id = theid
        self.name = name
        self.balance = balance
        self.latitude = latitude
        self.longitude = longitude
    }
}
