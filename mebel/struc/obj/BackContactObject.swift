//
//  BackContactObject.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class BackContactObject : Codable{
    
    var name:String;
    var email:String;
    var phone:String;
    var message:String;
    
    init() {
        self.name = "";
        self.email = "";
        self.phone = "";
        self.message = "";
    }
    
}
