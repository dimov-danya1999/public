//
//  WorkTimeItem.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class WorkTimeItem:Codable {
    
    var day:String;
    var start:String;
    var end:String;
    
    init() {
        self.day = "";
        self.start = "";
        self.end = "";
    }
}
