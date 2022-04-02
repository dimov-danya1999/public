//
//  MenuProductItemCell.swift
//  mebel
//
//  Created by DS on 05.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit

class MenuProductItemCell:UICollectionViewCell{
        
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var valuta: UILabel!
    @IBOutlet weak var btnAddStack: UIStackView!
    @IBOutlet weak var btnAddIcon: UIImageView!
    @IBOutlet weak var btnAddName: UILabel!
    
    var item:ProductItem!
    
    @objc func tapAdd(){
        
        if(ViewController.account == nil){
            let result = (ViewController.sb.instantiateViewController(withIdentifier: "AccountLogin")) as! AccountLogin as AccountLogin
            ViewController.nv.pushViewController(result, animated:true)
            return
        }

        let result = (ViewController.sb.instantiateViewController(withIdentifier: "AddToBasketDialog")) as! AddToBasketDialog as AddToBasketDialog
        result.product = item;
        ViewController.nv.present(result, animated: false, completion: nil)

    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let tapAdd = UITapGestureRecognizer(target: self, action: #selector(self.tapAdd))
        tapAdd.numberOfTapsRequired = 1
        btnAddStack.isUserInteractionEnabled = true
        btnAddStack.addGestureRecognizer(tapAdd)
    }
    
}
