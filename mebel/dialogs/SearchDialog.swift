//
//  SearchDialog.swift
//  mebel
//
//  Created by DS on 13.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SearchDialog:UIViewController{
  
    @IBOutlet weak var back: UIView!
    @IBOutlet weak var btnsearch: UIButton!
    @IBOutlet weak var btncancel: UIButton!
    @IBOutlet weak var edittext: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btncancel.layer.cornerRadius = 5;
        btnsearch.layer.cornerRadius = 5;
        
        MenuAdapter.setBackStyle(layer: back.layer)
        
        btncancel.layer.cornerRadius = 5
        btncancel.layer.borderWidth = 0.5
        btncancel.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
        btnsearch.layer.cornerRadius = 5
        btnsearch.layer.borderWidth = 0.5
        btnsearch.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        
               
    }
        
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
    }
    
    @IBAction func search(_ sender: Any) {
        self.dismiss(animated:true, completion:{
            let text = self.edittext.text;
            if text!.count > 0 {
                _ = GetSearch(text: text!, add: false)
            }
        })
    }
    
}
