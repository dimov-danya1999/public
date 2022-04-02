//
//  Testering.swift
//  mebel
//
//  Created by DS on 30.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit
import QGrid
import SwiftUI


struct PeopleView: View {
  var body: some View {
    QGrid(ViewController.categories, columns: 3) { GridCell(person: $0) }
  }
}

struct GridCell: View {
  var person: CategoryItem
  var body: some View {
    VStack() {
      //Image(person.imageName).resizable().scaledToFit()
      Text(person.name).font(.headline)
      Text(person.id).font(.headline)
    }
  }
}
