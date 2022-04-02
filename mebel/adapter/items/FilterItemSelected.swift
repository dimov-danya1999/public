//
//  FilterItemSelected.swift
//  mebel
//
//  Created by DS on 25.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI

class FilterItemSelected:UITableViewCell{
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var back: UIStackView!
    @IBOutlet weak var value: UILabel!
    
    var tapCancel:(() -> ()) = {}
    @IBAction func cancel(_ sender: Any) {
        tapCancel()
    }
    
}
