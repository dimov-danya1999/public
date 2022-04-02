//
//  Banner.swift
//  mebel
//
//  Created by Dima Chibuk on 30.11.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class Banner:Codable {
    
    var url:String
    var icon:String
    var id:String
    var type:String
    
    init() {
        self.url = ""
        self.icon = ""
        self.id = ""
        self.type = TypeBanners.NEWS.type()
    }
}
