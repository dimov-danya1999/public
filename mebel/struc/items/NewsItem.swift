//
//  NewsItem.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class NewsItem: Codable{
    
    var id:String;
    var date:String;
    var head:String;
    var type:String;
    var icon:String;
    
    init() {
        self.id = "";
        self.date = "";
        self.head = "";
        self.type = "";
        self.icon = "";
    }
}

