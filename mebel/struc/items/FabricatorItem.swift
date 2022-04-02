//
//  FabricatorItem.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class FabricatorItem:Codable{
    
    var id:String
    var name:String
    var country:CountryObject!
    
    init() {
        self.id = ""
        self.name = ""
        self.country = CountryObject()
    }
}
