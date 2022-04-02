//
//  AuthItem.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class AuthItem: Codable{
    
    var email:String;
    var password:String;
    
    init() {
        self.email = "";
        self.password = "";
    }
}
