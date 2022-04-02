//
//  MenuItemCell.swift
//  mebel
//
//  Created by DS on 04.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI

class MenuItemCell:UICollectionViewCell{
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    var tapCancel:(() -> ()) = {}
    @IBAction func cancel(_ sender: Any) {
        tapCancel();
    }
    
}
