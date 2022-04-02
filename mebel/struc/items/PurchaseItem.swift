//
//  PurchaseItem.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class PurchaseItem : Codable{
    
    var id:String;
    var date:String;
    var number:String;
    var status:String;
    var size:Float;
    var price:Float;
    var types:Int;
    
    init() {
        self.id = "";
        self.number = "";
        self.status = "";
        self.size = 0;
        self.price = 0;
        self.types = 0;
        self.date = "";
    }
    
}
