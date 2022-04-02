//
//  Progress.swift
//  mebel
//
//  Created by DS on 29.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit

class ProgressBar{
    
    internal static var spinner:UIActivityIndicatorView?;
    
    public static func show(){
        if spinner == nil, let window = UIApplication.shared.keyWindow{
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.backgroundColor = UIColor(white: 0, alpha: 0.6)
            spinner?.style = UIActivityIndicatorView.Style.whiteLarge
            spinner?.color = Colors.hexStringToUIColor(hex:Colors.appColor)
            window.addSubview(spinner!)
            spinner?.startAnimating()
        }
    }
    
    public static func dismiss(){
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        spinner = nil
    }
    
}
