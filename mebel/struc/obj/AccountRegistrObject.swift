//
//  AccountRegistr.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class AccountRegistrObject:Codable{
    
    var name:String;
    var phone:String;
    var email:String;
    var password:String;
    var lastname:String;
    var firstname:String;
    var date:Int;
    var month:Int;
    var year:Int;
    
    init(){
        self.name = "";
        self.phone = "";
        self.email = "";
        self.password = "";
        self.lastname = "";
        self.firstname = "";
        self.date = 1;
        self.month = 1;
        self.year = 1900;
    }
    
}
