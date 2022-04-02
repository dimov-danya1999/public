//
//  NewsObject.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class NewsObject:Codable{
    
    var id:String;
    var date:String;
    var head:String;
    var type:String;
    var description:[StatiaItem];
    var icon:String;
    
    init() {
        self.id = "";
        self.date = "";
        self.type = "";
        self.head = "";
        self.description = [];
        self.icon = "";
    }
    
}
