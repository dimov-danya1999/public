//
//  NewsAdapter.swift
//  mebel
//
//  Created by DS on 01.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class NewsAdapter:UITableViewController{
            
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !NewsActivity.enableAdd {
            return
        }
        let height = scrollView.frame.size.height;
        let offset = scrollView.contentOffset.y;
        let disFromBotom = scrollView.contentSize.height - offset;
        if(disFromBotom < height){
            NewsActivity.enableAdd = false;
            _ = GetNews(add:true);
        }
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item:NewsItem = NewsActivity.items[indexPath.row];
                
        let result = (NewsActivity.sb.instantiateViewController(withIdentifier: "NewsOpenActivity")) as! NewsOpenActivity as NewsOpenActivity
        result.id = item.id;
        NewsActivity.nv.pushViewController(result, animated:true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsActivity.items.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let item:NewsItem = NewsActivity.items[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItemCell", for: indexPath) as! NewsItemCell
        
        _ = SetText(label: cell.head, value: item.head)
        _ = SetText(label: cell.date, value: item.date)
        _ = LoadImage(img: cell.icon, url: item.icon)
        
        cell.layer.cornerRadius = 10;
        cell.layer.borderWidth = 3;
        if #available(iOS 13.0, *) {
            cell.layer.borderColor = UIColor.systemGray4.cgColor
        } else {
            cell.layer.borderColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1).cgColor
        }
        
        return cell;
    }
    
}

