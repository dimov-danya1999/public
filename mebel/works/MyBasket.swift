//
//  MyBasket.swift
//  mebel
//
//  Created by DS on 21.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation

class MyBasket{
    
    var baskets:[BasketObject] = [];
    //dialog
        
    func addToBasket(product:ProductItem, size:Int){
        
        var contain:Bool = false;
        _ = product.price * Float(size);
                
        for basket in baskets {
            if(basket.id == product.id){
                basket.size = basket.size + Float(size);
                basket.price = basket.price + product.price;
                //basket.fullPrice = basket.fullPrice + fullPrice;
                contain = true;
                break;
            }
        }
        
        if(!contain){
            let newBasket:BasketObject = BasketObject();
            newBasket.id = product.id;
            newBasket.name = product.name;
            newBasket.icon = product.icon;
            newBasket.size = Float(size);
            newBasket.price = product.price;
            //newBasket.fullPrice = fullPrice;
            baskets.append(newBasket);
        }
        
    }
    
    func addToBasket(product:ProductObject, size:Int){
        
        var contain:Bool = false;
        //let fullPrice = product.price * Float(size);
        
        for basket in baskets {
            if(basket.id == product.id){
                basket.size = basket.size + Float(size);
                basket.price = basket.price + product.price;
                //basket.fullPrice = basket.fullPrice + fullPrice;
                contain = true;
                break;
            }
        }
        
        if(!contain){
            let newBasket:BasketObject = BasketObject();
            newBasket.id = product.id;
            newBasket.name = product.name;
            newBasket.icon = product.icon;
            newBasket.size = Float(size);
            newBasket.price = product.price;
            //newBasket.fullPrice = fullPrice;
            baskets.append(newBasket);
        }
        
    }
}
