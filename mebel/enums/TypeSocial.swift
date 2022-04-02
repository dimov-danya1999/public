//
//  TypeSocial.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

enum TypeSocial:String{
    case Instagram
    case Facebook
    case VK
    case OK
    case YouTube
    case Twitter
    case Site
    
    func type()->String{
        return self.rawValue
    }
}
