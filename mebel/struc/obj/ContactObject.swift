//
//  ContactObject.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class ContactObject:Codable{
    
    var id:String;
    var name:String;
    var adress:String;
    var map:String;
    var contacts:[ParamItem];
    var socials:[SocialItem];
    var work_time:[WorkTimeItem];
    
    init() {
        self.id = "";
        self.name = "";
        self.adress = "";
        self.map = "";
        self.contacts = [];
        self.socials = [];
        self.work_time = [];
    }
}
