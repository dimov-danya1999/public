//
//  LoadImage.swift
//  mebel
//
//  Created by Dima Chibuk on 7/19/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Kingfisher

class LoadImage{
    
    init(img: UIImageView, url: String) {
        img.kf.setImage(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!))
        img.layer.cornerRadius = 5
    }
    
}
