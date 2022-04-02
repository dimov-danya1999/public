//
//  PurchaseItemCellEditable.swift
//  mebel
//
//  Created by Dima Chibuk on 7/20/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import SwiftUI

class PurchaseItemCellEditable:UICollectionViewCell{
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var fullPrice: UILabel!
    @IBOutlet weak var size: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var valuta: UILabel!
      
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
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


