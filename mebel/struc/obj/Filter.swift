//
//  Filter.swift
//  mebel
//
//  Created by DS on 24.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class Filter:Codable{
    
    var id:String;
    var name:String;
    var values:[String];
    
    init() {
        self.id = "";
        self.name = "";
        self.values = [];
    }
    
}
