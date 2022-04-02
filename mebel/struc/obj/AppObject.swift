//
//  AppObject.swift
//  mebel
//
//  Created by Dima Chibuk on 7/21/21.
//  Copyright © 2021 DS. All rights reserved.
//


import Foundation

class AppObject:Codable{
    
    var eposPablickKey: String
    var eposPrivateKey: String
    var payPalClientID: String
    var payPalSecretKey: String
    
    init() {
        self.eposPablickKey = ""
        self.eposPrivateKey = ""
        self.payPalClientID = ""
        self.payPalSecretKey = ""
    }
     
}
