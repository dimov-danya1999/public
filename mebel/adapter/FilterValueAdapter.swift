//
//  FilterValueAdapter.swift
//  mebel
//
//  Created by DS on 27.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI

class FilterValueAdapter:UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        debugPrint(FiltersVarianActivity.filter.values.count)
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let value:String = FiltersVarianActivity.filter.values[indexPath.row];
                
        let newItem:FilterSelected = FilterSelected();
        newItem.id = FiltersVarianActivity.filter.id;
        newItem.value = value;
        newItem.name = FiltersVarianActivity.filter.name;
        
        FiltersActivity.filterSubmit.filters.append(newItem);
        FiltersActivity.tvSelecteds.reloadData()
        
        FiltersVarianActivity.nv.self.popViewController(animated: true)
        
    }
      
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FiltersVarianActivity.filter.values.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let item:String = FiltersVarianActivity.filter.values[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterValueItem", for: indexPath) as! FilterValueItem
        
        _ = SetText(label: cell.name, value: item)
        
        MenuAdapter.setBackStyle(layer: cell.back.layer)
        
        return cell;
    }
    
}
