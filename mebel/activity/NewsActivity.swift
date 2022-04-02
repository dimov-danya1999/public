//
//  NewsActivity.swift
//  mebel
//
//  Created by DS on 01.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import Alamofire

class NewsActivity: UIViewController {
    
    public static var adapter:NewsAdapter = NewsAdapter()
        
    public static var tableView:UITableView!
   
    public static var items:[NewsItem] = [];
        
    public static var enableAdd:Bool = false;
    
    var adapter:NewsAdapter = NewsAdapter();
    
    public static var nv:UINavigationController = UINavigationController();
    public static var sb:UIStoryboard = UIStoryboard();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsActivity.self.nv = self.navigationController!;
        NewsActivity.self.sb = self.storyboard!;
        initById()
        _ = GetNews(add: false)
    }
    
    func initById(){
        NewsActivity.tableView = self.view.viewWithTag(TagsView.tableNews) as? UITableView
    }
    
    public static func openactivity(){
        let result = (sb.instantiateViewController(withIdentifier: "NewsActivity")) as! NewsActivity as NewsActivity
        nv.pushViewController(result, animated:true)
        
    }
    
}
