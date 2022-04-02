//
//  TypeGridViewMenu.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

enum TypeGridViewMenu:String {
    case MENU
    case MENU_IN
    case CATEGORY
    case EARCH
    case NEWS
    case DISCONT
    case NOVELTY
    case CHOISE
    case PURCHASE
    case SEARCH
    
    func type() -> String {
        return self.rawValue;
    }
}
