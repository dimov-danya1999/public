//
//  BasketOpenItemCell.swift
//  mebel
//
//  Created by DS on 06.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI

class BasketOpenItemCell:UITableViewCell{
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullPrice: UILabel!
    @IBOutlet weak var size: UITextField!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var back: UIStackView!
    
    var tapCancel:(() -> ()) = {}
    @IBAction func cancel(_ sender: Any) {
        tapCancel()
    }
    
    var tapRemove:(() -> ()) = {}
    @IBAction func remove(_ sender: Any) {
        tapRemove()
    }
    
    var tapAdd:(() -> ()) = {}
    @IBAction func add(_ sender: Any) {
        tapAdd()
    }
    
}
