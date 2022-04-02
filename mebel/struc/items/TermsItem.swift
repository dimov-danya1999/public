//
//  TermsItem.swift
//  mebel
//
//  Created by Dima Chibuk on 30.11.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class TermsItem: Codable{
    
    var size:Int;
    var good:Recomanded;
    
    init() {
        self.size = 0;
        self.good = Recomanded.init();
    }
}

