//
//  SubscribeItem.swift
//  mebel
//
//  Created by Dima Chibuk on 7/21/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation

class SubscribeItem: Codable {
    
    var id:String;
    var icon:String;
    var name:String;
    var description:String;
    var date:String;
    var position:Int;
    
    init() {
        
        self.id = "";
        self.icon = "";
        self.name = "";
        self.description = "";
        self.date = "";
        self.position = 0;
    }
}
