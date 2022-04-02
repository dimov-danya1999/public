//
//  FilterAdapter.swift
//  mebel
//
//  Created by DS on 25.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI

class FilterAdapter:UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
       
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item:Filter = ViewController.filters[indexPath.row];
        let result = (FiltersActivity.sb.instantiateViewController(withIdentifier: "FiltersVarianActivity")) as! FiltersVarianActivity as FiltersVarianActivity
        FiltersVarianActivity.filter = item;
        FiltersActivity.nv.pushViewController(result, animated:true)
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.filters.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let item:Filter = ViewController.filters[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterItem", for: indexPath) as! FilterItem
        
        _ = SetText(label: cell.name, value: item.name.uppercased())
        
        MenuAdapter.setBackStyle(layer: cell.back.layer)
        
        return cell;
    }
    
}
