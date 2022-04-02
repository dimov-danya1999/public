//
//  PurchaseOpenListAdapter.swift
//  mebel
//
//  Created by Dima Chibuk on 7/20/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SwiftUI

class PurchaseOpenListAdapter:UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let inset:CGFloat = 5;
    let minimumLineSpacing:CGFloat = 10;
    let minimumInteritemSpacing:CGFloat = 10;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.contentInsetAdjustmentBehavior = .always;
        
        self.collectionView!.register(PurchaseItemCellEditable.self, forCellWithReuseIdentifier: "PurchaseItemCellEditable")
        
        self.collectionView!.register(PurchaseItemCellClosed.self, forCellWithReuseIdentifier: "PurchaseItemCellClosed")
        
    }
    
    init(){
        super.init(collectionViewLayout:UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsPerRow = 1
        var safeArea: CGFloat
        if #available(iOS 11.0, *) {
            safeArea = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
        } else {
            safeArea = topLayoutGuide.length
        }
        
        let marginsAndInsets = inset * 2 + safeArea + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: PurchaseOpenActivity.isEditable ? 140 : 120)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item:BasketObject = PurchaseOpenActivity.object.baskets[indexPath.row];
        let result = (ViewController.sb.instantiateViewController(withIdentifier: "ProductActivity")) as! ProductActivity as ProductActivity
        result.id = item.id;
        ViewController.nv.pushViewController(result, animated:true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PurchaseOpenActivity.object.baskets.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item:BasketObject = PurchaseOpenActivity.object.baskets[indexPath.row];
        
        if (PurchaseOpenActivity.isEditable) {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PurchaseItemCellEditable", for: indexPath) as! PurchaseItemCellEditable
            _ = SetText(label: cell.fullPrice, value: item.size * item.price, decimal: 2)
            _ = SetText(label: cell.size, value: item.size)
            _ = SetText(label: cell.name, value: item.name.uppercased())
            _ = SetText(label: cell.valuta, value: ViewController.account == nil ? "AZN" : ViewController.account.valuta.uppercased())
            _ = LoadImage(img: cell.icon, url: item.icon)
            
            MenuAdapter.setBackStyle(layer: cell.layer)
            
            cell.tapAdd = {
                item.size = item.size + 1;
                _ = SetText(label: cell.fullPrice, value: item.size * item.price, decimal: 2)
                _ = SetText(label: cell.size, value: item.size)
                _ = ChangeSizePurchase(id:PurchaseOpenActivity.object.id, product: item.id, size:Int(item.size))
            }
            
            cell.tapRemove = {
                if(item.size < 2){
                    return
                }
                
                item.size = item.size - 1;
                _ = SetText(label: cell.fullPrice, value: item.size * item.price, decimal: 2)
                _ = SetText(label: cell.size, value: item.size)
                _ = ChangeSizePurchase(id:PurchaseOpenActivity.object.id, product: item.id, size:Int(item.size))
            }
            
            cell.tapCancel = {
                PurchaseOpenActivity.object.baskets.remove(at: indexPath.row)
                PurchaseOpenActivity.gridView.reloadData()
                _ = RemoveFromPurchase(id:PurchaseOpenActivity.object.id, product: item.id)
            }
            
            return cell
            
        }
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PurchaseItemCellClosed", for: indexPath) as! PurchaseItemCellClosed
        _ = SetText(label: cell.fullPrice, value: item.size * item.price, decimal: 2)
        _ = SetText(label: cell.size, value: item.size)
        _ = SetText(label: cell.name, value: item.name.uppercased())
        _ = SetText(label: cell.valuta, value: ViewController.account == nil ? "AZN" : ViewController.account.valuta.uppercased())
        _ = LoadImage(img: cell.icon, url: item.icon)
        
        MenuAdapter.setBackStyle(layer: cell.layer)
        
        return cell
        
    }
    
}
