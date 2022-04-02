//
//  PropertieItem.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class PropertieItem:Codable{
    
    var name: String
    var value: String
    
    init() {
        self.name = ""
        self.value = ""
    }
}
