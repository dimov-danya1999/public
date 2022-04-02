//
//  NotificationObject.swift
//  mebel
//
//  Created by Dima Chibuk on 7/19/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation

class NotificationObject:Codable{
    
    var head:String;
    var message:String;
    var icon:String;
    var type:String;
    var id:String;
    
    init() {
        self.head = ""
        self.message = ""
        self.icon = ""
        self.type = TypeBanners.NEWS.type()
        self.id = ""
    }
    
}
