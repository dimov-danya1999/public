//
//  Colors.swift
//  mebel
//
//  Created by Dima Chibuk on 7/19/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import SwiftUI

class Colors{
    
    public static let appColor:String = "#00B9C9";
    public static let appColor2:String = "#005A64";
    public static let appColor3:String = "#F4F4F4";
    public static let appColor4:String = "#C5C5C5";
    public static let appColor5:String = "#4E4E4E";
    public static let colorTransparent:String = "#00FFFFFF";
    public static let colorBlackTransparent50:String = "#80000000";
    public static let colorBlack:String = "#000000";
    public static let colorGold:String = "#FBC02D";
    public static let colorWhite:String = "#FFFFFF";
    public static let colorAccent:String = "#03DAC5";
    public static let colorPrimaryDark:String = "#000000";
    public static let colorPrimary:String = "#1E88E5";
    
    public static let statusInProgress:String = "#F57C00";
    public static let statusReject:String = "#DD2C00";
    public static let statusAccept:String = "#2481CC";
    public static let statusSended:String = "#36A03B";
    public static let markProduct:String = "#C00606";
    
    public static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
