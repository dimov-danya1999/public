//
//  SubscribeVariant.swift
//  mebel
//
//  Created by Dima Chibuk on 7/21/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation

class SubscribeVariant: Codable {
    
    var id:String;
    var icon:String;
    var name:String;
    var description:String;
    var price:Float;
    var priceAZN:Float;
    
    init() {
        
        self.id = "";
        self.icon = "";
        self.name = "";
        self.description = "";
        self.price = 0;
        self.priceAZN = 0;
    }
}
