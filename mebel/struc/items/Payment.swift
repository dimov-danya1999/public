//
//  Payment.swift
//  mebel
//
//  Created by Dima Chibuk on 30.11.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class Payment : Codable {

    var debt:Float
    var limit:Float
    var rest:Float
    var inbasket:Float
    
    init() {
        self.debt = 0
        self.limit = 0
        self.rest = 0
        self.inbasket = 0
    }

}

