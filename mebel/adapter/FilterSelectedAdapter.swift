//
//  FilterSelectedAdapter.swift
//  mebel
//
//  Created by DS on 28.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI

class FilterSelectedAdapter:UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if !NewsActivity.enableAdd {
//            return
//        }
//        let height = scrollView.frame.size.height;
//        let offset = scrollView.contentOffset.y;
//        let disFromBotom = scrollView.contentSize.height - offset;
//        if(disFromBotom < height){
//            NewsActivity.enableAdd = false;
//            _ = GetNews(add:true);
//        }
        //debugPrint(ViewController.filters.count)
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let item:Filter = ViewController.filters[indexPath.row];
//        debugPrint(item.name)
//
//        let result = (FiltersActivity.sb.instantiateViewController(withIdentifier: "FiltersVarianActivity")) as! FiltersVarianActivity as FiltersVarianActivity
//        FiltersVarianActivity.filter = item;
//        FiltersActivity.nv.pushViewController(result, animated:true)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FiltersActivity.filterSubmit.filters.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let item:FilterSelected = FiltersActivity.filterSubmit.filters[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterItemSelected", for: indexPath) as! FilterItemSelected
        
        _ = SetText(label: cell.value, value: item.value.uppercased())
        _ = SetText(label: cell.name, value: item.name.uppercased())
        
        cell.tapCancel = {
            FiltersActivity.filterSubmit.filters.remove(at: indexPath.row)
            FiltersActivity.tvSelecteds.reloadData();
        }
        
        MenuAdapter.setBackStyle(layer: cell.back.layer)
        
        return cell;
    }
    
}
