//
//  ProductObject.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class ProductObject:Codable{
    
    var id:String
    var name:String
    var icon:String
    var price:Float
    var price_opt:Float
    var price_discont:Float
    var discont:Bool
    var novelty:Bool
    var choise:Bool
    var fabricator:FabricatorItem!
    var articul:String
    var description:String
    var warranty:String!
    var category:String
    var rest:String!
    var colors:[String]
    var photos:[String]
    var properties:[PropertieItem]
    var recomandeds:[Recomanded]
    var terms:[Terms]
    
    init() {
        self.id = ""
        self.name = ""
        self.icon = ""
        self.price = 0
        self.price_opt = 0
        self.price_discont = 0
        self.discont = false
        self.novelty = false
        self.choise = false
        self.rest = "0"
        self.fabricator = FabricatorItem()
        self.articul = ""
        self.description = ""
        self.warranty = ""
        self.category = ""
        self.colors = []
        self.photos = []
        self.properties = []
        self.recomandeds = []
        self.terms = []
    }
   
}
