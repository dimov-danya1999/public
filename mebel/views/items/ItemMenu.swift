//
//  ItemMenu.swift
//  mebel
//
//  Created by DS on 30.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit

struct ItemMenu:View{
    
    var body: some View {
      QGrid(Storage.people, columns: 3) { GridCell(person: $0) }
    }
    
    
}
