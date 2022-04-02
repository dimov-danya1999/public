//
//  TypeNews.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

enum TypeNews:String{
    case Info
    case Sale
    case News
    
    func type()->String{
        return self.rawValue
    }
    
}
