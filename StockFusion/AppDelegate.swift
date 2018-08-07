//
//  AppDelegate.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-15.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var sharedStockData = StockRemoteDataShared()
    var stockData = StockAllViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //setting up firebase when app is lunched
        FirebaseApp.configure()
        
        
        // Override point for customization after application launch.
        sharedStockData.stockSharedModelObjects = stockData.stockRemoteState.stockSharedModelObjects
        
        
        //request permission from user whether or not they want to receive notifications from app
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("notification granted: \(granted)")
        }
        
        //implementing UNSuerNotificationCenterDelegate to present notification on forground too
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    //implementing the optional methods of the UserNotificationCenterDelegate so as to present alerts on forground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

