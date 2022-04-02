//
//  CategorieAdapter.swift
//  mebel
//
//  Created by DS on 30.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import SwiftUI
import QGrid
import UIKit
import hkAlium

class CategorieAdapter{
    
    init() {
        
    }
    
    struct PeopleView: View {
        var body: some View {
        //QGrid(ViewController.categories, columns: 3) { GridCell(person: $0) }
            do{
            
                
                QGrid(datas, columns: 3) { item(cat: $0) }
            
            } catch {
                debugPrint(error)
            }
        }
    }
    
    struct item: View{
        
        var cat:CategoryItem
        
        var body: some View {
            VStack() {
                //Image(person.imageName)
                //    .resizable()
                //    .scaledToFit()
                //    .clipShape(Circle())
                //    .shadow(color: .primary, radius: 5)
                //    .padding([.horizontal, .top], 7)
                Text(cat.name).lineLimit(1)
                Text(cat.id).lineLimit(1)
            }
        }
        
    }
}
