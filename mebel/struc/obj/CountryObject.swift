//
//  CountryObject.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class CountryObject:Codable{
    
    var id:String;
    var name:String;
    var iso:String;
    
    init() {
        self.id = "";
        self.name = "";
        self.iso = "";
    }
    
}
