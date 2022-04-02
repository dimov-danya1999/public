//
//  AppDelegate.swift
//  mebel
//
//  Created by DS on 20.04.2020.
//  Copyright © 2020 DS. All rights reserved.
//

import UIKit
import Pushy

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let pushy = Pushy(UIApplication.shared)
        
        pushy.register({ (error, deviceToken) in
            if error != nil {
                return print ("Registration failed AppDelegate: \(error!.localizedDescription)")
            }
            //_ = SetToken(token: deviceToken)
            UserDefaults.standard.set(deviceToken, forKey: "pushyToken")
        })
        
        pushy.toggleInAppBanner(true)
        
        pushy.setNotificationHandler({ (data, completionHandler) in
            
            let alert = UIAlertController(title: data["title"] as? String, message: data["message"] as? String, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default)
            {action -> Void in
                
                do {
                    
                    let struc: String = data["struc"] as! String
                    let notification: NotificationObject = try JSONDecoder().decode(NotificationObject.self, from: Data(struc.utf8))
                    
                    if (notification.type.elementsEqual("URL")){
                        
                        let url = URL(string: notification.id)!
                        UIApplication.shared.open(url)
                        
                    } else if notification.type.elementsEqual("NEWS")
                        || notification.type.elementsEqual("GOOD") {
                        
                        let rootViewController = self.window!.rootViewController as! UINavigationController
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        let result = (sb.instantiateViewController(withIdentifier: "ViewController")) as! ViewController as ViewController
                        result.newNotification = notification
                        rootViewController.pushViewController(result, animated: true)
                        
                    }
                    
                } catch {
                    print(error)
                }
                
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
             
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            UIApplication.shared.applicationIconBadgeNumber = 0
            completionHandler(UIBackgroundFetchResult.newData)
        })
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

