//
//  SL.swift
//  mebel
//
//  Created by DS on 19.05.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class SL{
    
    
    public static func saveAuth(email:String, password:String){
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    public static func getAuth() -> AuthItem!{
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        
        if(email == nil || password == nil){
            return nil
        }
        
        let authItem:AuthItem = AuthItem();
        authItem.email = email!;
        authItem.password = password!;
        
        return authItem
    }
    
    public static func deleteAuth(){
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
    }
}
