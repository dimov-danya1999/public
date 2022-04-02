//
//  SetText.swift
//  mebel
//
//  Created by Dima Chibuk on 7/19/21.
//  Copyright © 2021 DS. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

class SetText{
    
    init(label: UILabel, value: String) {
        label.text = value
    }
    
    init(label: UILabel, value: String, trim: Bool){
        label.text = trim ? value.trimmingCharacters(in: .whitespacesAndNewlines) : value
    }
    
    init(label: UILabel, value: Float){
        label.text = String(format: "%.2f", value)
    }
    
    init(label: UILabel, value: Int) {
        label.text = String(format: "%.2f", Float(value))
    }
    
    init(label: UILabel, value: Float, decimal: Int) {
        label.text = String(format: "%." + String(decimal) + "f", value)
    }
    
    init(label: UILabel, value: String, decimal: Int){
        
        do {
            let fValue = (value as NSString).floatValue
            label.text = String(format: "%." + String(decimal) + "f", fValue)
        } catch {
            label.text = value
        }
        
    }
    
    
    init(label: UITextField, value: String) {
        label.text = value
    }
    
    init(label: UITextField, value: String, trim: Bool){
        label.text = trim ? value.trimmingCharacters(in: .whitespacesAndNewlines) : value
    }
    
    init(label: UITextField, value: Float){
        label.text = String(format: "%.2f", value)
    }
    
    init(label: UITextField, value: Int) {
        label.text = String(format: "%.2f", Float(value))
    }
    
    init(label: UITextField, value: Float, decimal: Int) {
        label.text = String(format: "%." + String(decimal) + "f", value)
    }
    
    init(label: UITextField, value: String, decimal: Int){
        
        do {
            let fValue = (value as NSString).floatValue
            label.text = String(format: "%." + String(decimal) + "f", fValue)
        } catch {
            label.text = value
        }
        
    }
    
    
    init(label: UITextView, value: String) {
        label.text = value
    }
    
    init(label: UITextView, value: String, trim: Bool){
        label.text = trim ? value.trimmingCharacters(in: .whitespacesAndNewlines) : value
    }
    
    init(label: UITextView, value: Float){
        label.text = String(format: "%.2f", value)
    }
    
    init(label: UITextView, value: Int) {
        label.text = String(format: "%.2f", Float(value))
    }
    
    init(label: UITextView, value: Float, decimal: Int) {
        label.text = String(format: "%." + String(decimal) + "f", value)
    }
    
    init(label: UITextView, value: String, decimal: Int){
        
        do {
            let fValue = (value as NSString).floatValue
            label.text = String(format: "%." + String(decimal) + "f", fValue)
        } catch {
            label.text = value
        }
        
    }
    
}
