//
//  PurchaseAdapter.swift
//  mebel
//
//  Created by DS on 01.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit

class PurchaseAdapter:UITableViewController{
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = UITableView.automaticDimension
    }
      
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !PurchaseActivity.enableAdd {
            return
        }
        let height = scrollView.frame.size.height;
        let offset = scrollView.contentOffset.y;
        let disFromBotom = scrollView.contentSize.height - offset;
        if(disFromBotom < height){
            PurchaseActivity.enableAdd = false;
            _ = GetPurchase(add:true);
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item:PurchaseItem = PurchaseActivity.items[indexPath.row];
                
        let result = (PurchaseActivity.sb.instantiateViewController(withIdentifier: "PurchaseOpenActivity")) as! PurchaseOpenActivity as PurchaseOpenActivity
        result.id = item.id;
        
        PurchaseActivity.nv.pushViewController(result, animated:true)
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 5
//    }
    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        //cell.separatorInset = UIEdgeInsets(top: 0, left: 100, bottom: 5, right: 100)
//        cell.layoutMargins = UIEdgeInsets(top: 50, left: 25, bottom: 0, right: 25)
//        cell.preservesSuperviewLayoutMargins = false
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PurchaseActivity.items.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let item:PurchaseItem = PurchaseActivity.items[indexPath.row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseItemCell", for: indexPath) as! PurchaseItemCell
        
        _ = SetText(label: cell.number, value: item.number)
        _ = SetText(label: cell.date, value: item.date)
        _ = SetText(label: cell.status, value: item.status)
        _ = SetText(label: cell.types, value: item.types.description)
        _ = SetText(label: cell.price, value: item.price, decimal: 2)
        _ = SetText(label: cell.size, value: item.size)
        
        cell.layer.cornerRadius = 5
        cell.layer.shadowColor = Colors.hexStringToUIColor(hex: Colors.appColor4).cgColor
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 4.0
        cell.layer.masksToBounds = false
        
        cell.topPanel.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
        cell.topPanel.layer.cornerRadius = 5;
        
        if item.status == PurchaseStatus.Sended.rawValue{
            cell.status.textColor = Colors.hexStringToUIColor(hex: Colors.statusSended)
        } else if item.status == PurchaseStatus.Accept.rawValue{
            cell.status.textColor = Colors.hexStringToUIColor(hex: Colors.statusAccept)
        } else if item.status == PurchaseStatus.Cancel.rawValue{
            cell.status.textColor = Colors.hexStringToUIColor(hex: Colors.statusReject)
        } else if item.status == PurchaseStatus.Stay.rawValue{
            cell.status.textColor = Colors.hexStringToUIColor(hex: Colors.statusInProgress)
        }
                        
        return cell;
    }
    
}
