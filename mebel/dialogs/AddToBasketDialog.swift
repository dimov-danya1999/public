//
//  AddToBasketDialog.swift
//  mebel
//
//  Created by DS on 06.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class AddToBasketDialog:UIViewController{
    
    @IBOutlet weak var fullPrice: UILabel!
    @IBOutlet weak var size: UITextField!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet var activity: UIView!
    
    var curSize:Int = 1;
    var product:ProductItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCancel.layer.cornerRadius = 5
        btnCancel.layer.borderWidth = 0.5
        btnCancel.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
        btnAdd.layer.cornerRadius = 5
        btnAdd.layer.borderWidth = 0.5
        btnAdd.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
        MenuAdapter.setBackStyle(layer: back.layer)
        
        _ = LoadImage(img: icon, url: product!.icon)
        _ = SetText(label: name, value: product!.name)
        _ = SetText(label: fullPrice, value: product!.price, decimal: 2)
        _ = SetText(label: size, value: curSize)
        
    }
    
    
    @IBAction func remove(_ sender: Any) {
        if(curSize > 1){
            curSize = curSize - 1;
            _ = SetText(label: size, value: curSize)
            _ = SetText(label: fullPrice, value: Float(curSize) * product!.price, decimal: 2)
        }
    }
    
    @IBAction func add(_ sender: Any) {
        curSize = curSize + 1;
        _ = SetText(label: size, value: curSize)
        _ = SetText(label: fullPrice, value: Float(curSize) * product!.price, decimal: 2)
    }
    
    @IBAction func toBasket(_ sender: Any) {
        self.dismiss(animated:true, completion:{
            BasketWork().add(product: self.product!.id, size: self.curSize)
        })
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
    }
    
    
}
