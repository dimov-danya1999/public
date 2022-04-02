//
//  MenuAdapter.swift
//  mebel
//
//  Created by DS on 04.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SwiftUI

class MenuAdapter:UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let inset:CGFloat = 10;
    let minimumLineSpacing:CGFloat = 10;
    let minimumInteritemSpacing:CGFloat = 10;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.contentInsetAdjustmentBehavior = .always;
        
        self.collectionView!.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        self.collectionView!.register(MenuProductItemCell.self, forCellWithReuseIdentifier: "MenuProductItemCell")
        self.collectionView!.register(MenuNewsItemCell.self, forCellWithReuseIdentifier: "MenuNewsItemCell")
        self.collectionView!.register(MenuPurchaseItemCell.self, forCellWithReuseIdentifier: "MenuPurchaseItemCell")
        
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
        
        var cellsPerRow = 3
        var safeArea: CGFloat
        if #available(iOS 11.0, *) {
            safeArea = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
        } else {
            safeArea = topLayoutGuide.length
        }
        
        if(ViewController.typeMenu == TypeGridViewMenu.CATEGORY
            || ViewController.typeMenu == TypeGridViewMenu.SEARCH){
            cellsPerRow = ViewController.isIpad ? 3 : 2
        } else if(ViewController.typeMenu == TypeGridViewMenu.NEWS
            || ViewController.typeMenu == TypeGridViewMenu.PURCHASE){
            cellsPerRow = 1
        }
        
        let marginsAndInsets = inset * 2 + safeArea + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        
        if(ViewController.typeMenu == TypeGridViewMenu.NEWS){
            return CGSize(width: itemWidth, height: 250)
        } else if(ViewController.typeMenu == TypeGridViewMenu.PURCHASE){
            return CGSize(width: itemWidth, height: 120)
        }
        
        return CGSize(width: itemWidth, height: itemWidth * 1.5)
    }
   
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height;
        let offset = scrollView.contentOffset.y;
        let disFromBotom = scrollView.contentSize.height - offset;
        if(disFromBotom < height){
            
            if(ViewController.typeMenu == TypeGridViewMenu.CATEGORY
                        && ViewController.enableAdd){
                ViewController.enableAdd = false;
                _ = GetCategory(add:true)
            } else if(ViewController.typeMenu == TypeGridViewMenu.SEARCH
                        && ViewController.enableAdd){
                ViewController.enableAdd = false;
                _ = GetSearch(text: ViewController.lastSearch, add: true)
            } else if(ViewController.typeMenu == TypeGridViewMenu.NEWS
                        && ViewController.enableAddNews){
                ViewController.enableAddNews = false
                _ = GetNews(add: true)
            } else if(ViewController.typeMenu == TypeGridViewMenu.PURCHASE
                        && ViewController.enableAddPurchase){
                ViewController.enableAddPurchase = false
                _ = GetPurchase(add: true)
            }
            
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.3, animations: {
            collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: {_ in
        
            UIView.animate(withDuration: 0.3, animations: {
                collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: {_ in
                
                if(ViewController.typeMenu == TypeGridViewMenu.MENU){
                    
                    if (indexPath.row >= ViewController.categories.count){
                        return
                    }
                    
                    let item:CategoryItem = ViewController.categories[indexPath.row];
                    _ = GetMenu(id:item.id, fromMenu: true)
                    ViewController.category = item.id;
                    _ = GetFilters(show:false);
                } else if(ViewController.typeMenu == TypeGridViewMenu.MENU_IN){
                    
                    if (indexPath.row >= ViewController.categories_in.count){
                        return
                    }
                    
                    let item:CategoryItem = ViewController.categories_in[indexPath.row];
                    ViewController.idMenu = item.id;
                    _ = GetCategory(add:false)
                    ViewController.category = item.id;
                    _ = GetFilters(show:false);
                } else if(ViewController.typeMenu == TypeGridViewMenu.CATEGORY
                    || ViewController.typeMenu == TypeGridViewMenu.SEARCH){
                    
                    if (indexPath.row >= ViewController.products.count){
                        return
                    }
                    
                    let item:ProductItem = ViewController.products[indexPath.row];
                    let result = (ViewController.sb.instantiateViewController(withIdentifier: "ProductActivity")) as! ProductActivity as ProductActivity
                    result.id = item.id;
                    result.item = item;
                    ViewController.nv.pushViewController(result, animated:true)
                } else if(ViewController.typeMenu == TypeGridViewMenu.NEWS){
                    
                    if (indexPath.row >= ViewController.news.count){
                        return
                    }
                    
                    let item:NewsItem = ViewController.news[indexPath.row]
                    let result = (ViewController.sb.instantiateViewController(withIdentifier: "NewsOpenActivity")) as! NewsOpenActivity as NewsOpenActivity
                    result.id = item.id;
                    ViewController.nv.pushViewController(result, animated:true)
                } else if(ViewController.typeMenu == TypeGridViewMenu.PURCHASE){
                    
                    if (indexPath.row >= ViewController.purchases.count){
                        return
                    }
                    
                    let item:PurchaseItem = ViewController.purchases[indexPath.row]
                    let result = (ViewController.sb.instantiateViewController(withIdentifier: "PurchaseOpenActivity")) as! PurchaseOpenActivity as PurchaseOpenActivity
                    result.id = item.id;
                    ViewController.nv.pushViewController(result, animated:true)
                }
            
            })
        
        })
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(ViewController.typeMenu == TypeGridViewMenu.PURCHASE){
            return ViewController.purchases.count
        } else if(ViewController.typeMenu == TypeGridViewMenu.NEWS){
            return ViewController.news.count
        } else if(ViewController.typeMenu == TypeGridViewMenu.MENU){
            return ViewController.categories.count
        } else if(ViewController.typeMenu == TypeGridViewMenu.MENU_IN){
            return ViewController.categories_in.count
        } else {
            return ViewController.products.count;
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if(ViewController.typeMenu == TypeGridViewMenu.CATEGORY
            || ViewController.typeMenu == TypeGridViewMenu.SEARCH){
            let item = ViewController.products[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuProductItemCell", for: indexPath) as! MenuProductItemCell
            
            cell.item = item
            
            _ = SetText(label: cell.name, value: item.name)
            _ = SetText(label: cell.valuta, value: ViewController.account == nil ? "AZN" : ViewController.account.valuta.uppercased())
            _ = SetText(label: cell.price, value: item.price, decimal: 2)
            _ = LoadImage(img: cell.icon, url: item.icon)
            
            MenuAdapter.setBackStyle(layer: cell.layer)
            
            cell.btnAddStack.layer.cornerRadius = 5
            cell.btnAddStack.layer.borderWidth = 0.5
            cell.btnAddStack.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
            
            MenuAdapter.animateSize(cell: cell)
            
            return cell
            
        } else if(ViewController.typeMenu == TypeGridViewMenu.NEWS){
            
            let item = ViewController.news[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuNewsItemCell", for: indexPath) as! MenuNewsItemCell
            
            _ = SetText(label: cell.head, value: item.head)
            _ = SetText(label: cell.date, value: item.date)
            _ = LoadImage(img: cell.icon, url: item.icon)
            
            MenuAdapter.setBackStyle(layer: cell.layer)
            MenuAdapter.animateSize(cell: cell)
            
            return cell
            
        } else if(ViewController.typeMenu == TypeGridViewMenu.PURCHASE){
            
            let item = ViewController.purchases[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuPurchaseItemCell", for: indexPath) as! MenuPurchaseItemCell
            
            _ = SetText(label: cell.number, value: item.number)
            _ = SetText(label: cell.date, value: item.date)
            _ = SetText(label: cell.status, value: item.status)
            _ = SetText(label: cell.types, value: item.types)
            _ = SetText(label: cell.price, value: item.price)
            _ = SetText(label: cell.size, value: item.size)
            
            if item.status == PurchaseStatus.Sended.rawValue{
                cell.status.textColor = Colors.hexStringToUIColor(hex: Colors.statusSended)
            } else if item.status == PurchaseStatus.Accept.rawValue{
                cell.status.textColor = Colors.hexStringToUIColor(hex: Colors.statusAccept)
            } else if item.status == PurchaseStatus.Cancel.rawValue{
                cell.status.textColor = Colors.hexStringToUIColor(hex: Colors.statusReject)
            } else if item.status == PurchaseStatus.Stay.rawValue{
                cell.status.textColor = Colors.hexStringToUIColor(hex: Colors.statusInProgress)
            }
            
            MenuAdapter.setBackStyle(layer: cell.layer)
            
            cell.topPanel.layer.borderWidth = 0.5
            cell.topPanel.layer.borderColor = Colors.hexStringToUIColor(hex: Colors.colorBlack).cgColor
            cell.topPanel.layer.cornerRadius = 5;
            
            MenuAdapter.animateSize(cell: cell)
            
            return cell
        }
        
        var item:CategoryItem!;
        if(ViewController.typeMenu == TypeGridViewMenu.MENU){
            item = ViewController.categories[indexPath.row];
        } else if(ViewController.typeMenu == TypeGridViewMenu.MENU_IN){
            item = ViewController.categories_in[indexPath.row]
        }
                
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        
        _ = SetText(label: cell.name, value: item.name.uppercased())
        _ = LoadImage(img: cell.icon, url: item.icon)
        
        MenuAdapter.setBackStyle(layer: cell.layer)
        
        if(item.id.elementsEqual("NASHVIBOR")
            || item.id.elementsEqual("NOVINKI")
            || item.id.elementsEqual("AKCII")) {
            cell.layer.backgroundColor = Colors.hexStringToUIColor(hex: Colors.appColor).cgColor
            cell.name.textColor = Colors.hexStringToUIColor(hex: Colors.colorWhite)
        } else {
            cell.layer.backgroundColor = Colors.hexStringToUIColor(hex: Colors.colorWhite).cgColor
            cell.name.textColor = Colors.hexStringToUIColor(hex: Colors.appColor5)
        }
        
        MenuAdapter.animateSize(cell: cell)
        
        return cell
        
    }
    
    public static func animateSize(cell: UICollectionViewCell){
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.3, animations: {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    public static func setBackStyle(layer: CALayer){
        
        layer.cornerRadius = 5
        layer.shadowColor = Colors.hexStringToUIColor(hex: Colors.appColor4).cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
        
    }
    
}
