//
//  FilterSubmit.swift
//  mebel
//
//  Created by DS on 24.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class FilterSubmit:Codable{
    
    var parent:String;
    var filters:[FilterSelected];
    
    init() {
        self.parent = "";
        self.filters = [];
    }
    
}
