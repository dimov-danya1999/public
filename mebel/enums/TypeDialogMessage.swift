//
//  TypeDialogMessage.swift
//  mebel
//
//  Created by DS on 25.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

enum TypeDialogMessage:String{
    case OK
    case OKCANCEL
    case CANCEL
    
    func type() -> String{
        return self.rawValue;
    }
}
