//
//  FiltersVarianActivity.swift
//  mebel
//
//  Created by DS on 27.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire

class FiltersVarianActivity:UIViewController{
    
    @IBOutlet weak var valuesTable: UITableView!
    
    public static var filter:Filter!
    public static var nv:UINavigationController = UINavigationController()
    var adapter:FilterValueAdapter = FilterValueAdapter()
    
    @IBOutlet weak var homeIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FiltersVarianActivity.self.nv = self.navigationController!
        
        makeIcons()
        
        valuesTable.delegate = adapter
        valuesTable.dataSource = adapter
        valuesTable.reloadData()
    }
    
    func makeIcons(){
        let tapHome = UITapGestureRecognizer(target: self,
                                                action: #selector(moveBack(_:)))
        tapHome.numberOfTapsRequired = 1
        homeIcon.addGestureRecognizer(tapHome)
        homeIcon.isUserInteractionEnabled = true
        homeIcon.image = homeIcon.image?.withRenderingMode(.alwaysTemplate).withAlignmentRectInsets(Paddings.minus10)
    }
    
    @objc func moveBack(_ sender: Any) {
        ViewController.nv.popViewController(animated: true)
    }
    
    @objc func selected(){
        dismiss(animated: true, completion: nil)
    }

}
