//
//  ProductItem.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class ProductItem :Codable{
    
    var name:String;
    var price:Float;
    var icon:String;
    var id:String;
    var rest:String!
    var price_opt:Float;
    var price_discont:Float;
    var discont:Bool;
    var novelty:Bool;
    var choise:Bool;
    
    init() {
        self.name = "";
        self.price = 0;
        self.icon = "";
        self.id = "";
        self.rest = "0";
        self.price_opt = 0;
        self.price_discont = 0;
        self.discont = false;
        self.novelty = false;
        self.choise = false;
    }
    
}

