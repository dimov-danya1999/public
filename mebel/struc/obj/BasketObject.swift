//
//  BasketObject.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class BasketObject:Codable{
    
    var id:String
    var name:String
    var icon:String
    var price:Float
    var price_opt:Float
    var price_discont:Float
    var size:Float
    var rest:Float
      
    init() {
        self.id = ""
        self.name = ""
        self.icon = ""
        self.price = 0
        self.price_opt = 0
        self.price_discont = 0
        self.size = 0
        self.rest = 0
    }
}
