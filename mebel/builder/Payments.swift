//
//  Payments.swift
//  mebel
//
//  Created by Dima Chibuk on 7/21/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import SwiftUI

class Payments{
    
    var context:UIViewController!
    var sum: Float
    
    init(context:UIViewController, sum: Float) {
        self.context = context
        self.sum = sum
        SelectVariant()
    }
    
    private func SelectVariant(){

        _ = EPOS(context: self.context, sum: self.sum)
        
    }
    
    
}

