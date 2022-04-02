//
//  BasketItem.swift
//  mebel
//
//  Created by DS on 06.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class BasketItem:Codable{
    
    var icon:String;
    var id:String;
    var name:String;
    var size:Float;
    var price:Float;
    
    init(){
        self.id = "";
        self.icon = "";
        self.name = "";
        self.size = 0;
        self.price = 0;
    }
    
}
