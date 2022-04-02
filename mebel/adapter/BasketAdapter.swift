//
//  BasketAdapter.swift
//  mebel
//
//  Created by DS on 06.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

class BasketAdapter:UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BasketActivity.baskets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let item:BasketItem = BasketActivity.baskets[indexPath.row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketOpenItemCell", for: indexPath) as! BasketOpenItemCell
        
        _ = SetText(label: cell.name, value: item.name.uppercased())
        _ = SetText(label: cell.size, value: item.size)
        _ = SetText(label: cell.fullPrice, value: item.size * item.price, decimal: 2)
        _ = LoadImage(img: cell.icon, url: item.icon)
        
        cell.tapCancel = {
            BasketActivity.baskets.remove(at: indexPath.row)
            BasketWork().cancel(product: item.id)
        }
        
        cell.tapRemove = {
            
            if(item.size > 1){
                item.size = item.size - 1
                _ = SetText(label: cell.size, value: item.size)
                _ = SetText(label: cell.fullPrice, value: item.size * item.price, decimal: 2)
                BasketWork().remove(product: item.id)
            }
            
        }
        
        cell.tapAdd = {
            item.size = item.size + 1
            _ = SetText(label: cell.size, value: item.size)
            _ = SetText(label: cell.fullPrice, value: item.size * item.price, decimal: 2)
            BasketWork().add(product: item.id, size: 1)
        }
        
        MenuAdapter.setBackStyle(layer: cell.back.layer)
                        
        return cell
    }
    
    
}
