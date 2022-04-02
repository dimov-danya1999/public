//
//  AccountObject.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class AccountObject:Codable{
    
    var id:String
    var name:String
    var valuta:String
    var password:String
    var email:String
    var payment:Payment
    
    init(){
        self.id = ""
        self.name = ""
        self.valuta = ""
        self.password = ""
        self.email = ""
        self.payment = Payment()
    }
    
}
