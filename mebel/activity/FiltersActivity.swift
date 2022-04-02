//
//  FiltersActivity.swift
//  mebel
//
//  Created by DS on 24.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire

class FiltersActivity:UIViewController{

    public static var tvFilters:UITableView!
    public static var tvSelecteds:UITableView!
    
    public static var nv:UINavigationController = UINavigationController();
    public static var sb:UIStoryboard = UIStoryboard();
            
    public static var filterSubmit:FilterSubmit = FilterSubmit();
    
    public static var filterAdapter = FilterAdapter();
    public static var filterSelectedsAdapter = FilterSelectedAdapter();
    
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var setIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FiltersActivity.filterSubmit.parent = ViewController.category!
        FiltersActivity.self.nv = self.navigationController!
        FiltersActivity.self.sb = self.storyboard!
        initById()
        makeIcons()
        buildView()
    }
    
    func initById(){
        FiltersActivity.tvFilters = self.view.viewWithTag(TagsView.tableFilters) as? UITableView
        FiltersActivity.tvSelecteds = self.view.viewWithTag(TagsView.tableFiltersSelected) as? UITableView
    }
    
    func makeIcons(){
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(moveBack(_:)))
        tapHome.numberOfTapsRequired = 1
        homeIcon.addGestureRecognizer(tapHome)
        homeIcon.isUserInteractionEnabled = true
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        
        let tapSet = UITapGestureRecognizer(target: self,
                                                action: #selector(set(_:)))
        tapSet.numberOfTapsRequired = 1
        setIcon.addGestureRecognizer(tapSet)
        setIcon.isUserInteractionEnabled = true
        setIcon.image = setIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
        setIcon.tintColor = UIColor.white
    }
    
    func buildView(){
        FiltersActivity.tvFilters.delegate =  FiltersActivity.filterAdapter;
        FiltersActivity.tvFilters.dataSource = FiltersActivity.filterAdapter;
        FiltersActivity.tvFilters.reloadData()
        
        FiltersActivity.tvSelecteds.delegate = FiltersActivity.filterSelectedsAdapter;
        FiltersActivity.tvSelecteds.dataSource = FiltersActivity.filterSelectedsAdapter;
        FiltersActivity.tvSelecteds.reloadData();
    }
    
    @objc func moveBack(_ sender: Any) {
        FiltersActivity.filterSubmit = FilterSubmit();
        ViewController.nv.popViewController(animated: true)
    }
    
    @objc func set(_ sender: Any) {
        
        if FiltersActivity.filterSubmit.filters.count < 1 {
            return
        }
        
        do{
            let jsonData = try JSONEncoder().encode(FiltersActivity.filterSubmit)
            let json = String(data:jsonData, encoding: String.Encoding.utf8)!
            submitFilters(json: json)
        } catch {
            debugPrint(error)
        }

    }
    
    func submitFilters(json:String){
        ProgressBar.show()
        
        let url:String = URLs.sayt + "/" + URLs.api + URLs.filtersSubmit
        
        var headers:HTTPHeaders = []
        headers.add(name: "Accept-Language", value: "*")
        headers.add(name: "Authorization", value: "Basic " + URLs.base64login)
        headers.add(name: "user", value: ViewController.account == nil ? "" : ViewController.account!.id)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = json.data(using: .utf8)
        request.headers = headers;
                
        URLs.session.request(request).responseJSON{ response in
            
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    do{
                        ViewController.products = try JSONDecoder().decode([ProductItem].self, from: response.data!)
                        ViewController.enableAdd = false
                        ViewController.gridView.reloadData()
                    } catch {
                        debugPrint(error)
                    }
                default:
                    return
                }
            }
            
            ProgressBar.dismiss()
            FiltersActivity.filterSubmit = FilterSubmit();
            FiltersActivity.nv.self.popViewController(animated: true)
            
        }
    }
    
}
