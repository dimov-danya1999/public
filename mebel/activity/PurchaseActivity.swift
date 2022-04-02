//
//  PurchaseActivity.swift
//  mebel
//
//  Created by DS on 01.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import Alamofire

class PurchaseActivity : UIViewController{
    
    public static var tableView: UITableView!
    
    public static var items:[PurchaseItem] = [];
    
    public static var enableAdd:Bool = false;
    
    public static var adapter:PurchaseAdapter = PurchaseAdapter();
    
    public static var nv:UINavigationController = UINavigationController();
    public static var sb:UIStoryboard = UIStoryboard();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PurchaseActivity.self.nv = self.navigationController!;
        PurchaseActivity.self.sb = self.storyboard!;
        initById()
        _ = GetPurchase(add:false);
    }
    
    func initById(){
        PurchaseActivity.tableView = self.view.viewWithTag(TagsView.tablePurchase) as? UITableView
    }
        
}
