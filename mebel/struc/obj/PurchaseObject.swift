//
//  PurchaseObject.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class PurchaseObject:Codable {
    
    var id:String;
    var date:String;
    var status:String;
    var comment:String;
    var number:String;
    var baskets:[BasketObject];
    
    init() {
        self.id = "";
        self.date = "";
        self.status = "";
        self.comment = "";
        self.number = "";
        self.baskets = [];
    }
}
