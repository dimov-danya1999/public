//
//  LanchIntent.swift
//  mebel
//
//  Created by Dima Chibuk on 7/19/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation

class LanchIntent:Codable{
    
    var id:String;
    var type:String
    
    init() {
        self.id = "";
        self.type = TypeBanners.NEWS.type()
    }
    
}

