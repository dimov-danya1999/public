//
//  FilterSelected.swift
//  mebel
//
//  Created by DS on 24.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class FilterSelected:Codable{
    
    var id:String;
    var value:String;
    var name:String;
    
    init() {
        self.id = "";
        self.value = "";
        self.name = "";
    }
    
}
