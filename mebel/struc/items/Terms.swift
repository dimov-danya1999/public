//
//  Terms.swift
//  mebel
//
//  Created by Dima Chibuk on 30.11.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class Terms: Codable{
    
    var size:Int;
    var goods:[TermsItem];
    
    init() {
        self.size = 0;
        self.goods = [];
    }
    
}
