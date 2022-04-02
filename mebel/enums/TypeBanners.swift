//
//  TypeBanners.swift
//  mebel
//
//  Created by Dima Chibuk on 30.11.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

enum TypeBanners:String{
    case NEWS
    case URL
    case GOOD
    
    func type()->String{
        return self.rawValue
    }
    
}
