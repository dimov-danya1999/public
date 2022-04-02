//
//  SocialItem.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class SocialItem:Codable{
    
    var type:String;
    var adress:String;
    
    init() {
        self.type = "";
        self.adress = "";
    }
}
