//
//  ViewController.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-07-15.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UITabBarController {
    

    var stockModelObjectsFromBaseController = [StockModel]()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //since this is the tab view controller all notification will be handled in here
        let content = UNMutableNotificationContent()
        content.title = "Stock Fusion Notification 🔔"
        content.body = "Stock Market Data Updates, New changes to stock price open on some stock. Check now!"
        content.sound = UNNotificationSound.default()
        
        //setting a trigger to trigger the notification after every 1 minute (10 seconds for testing purpose)
        let triggerNotification = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //setting an identifier for this notification
        let request = UNNotificationRequest(identifier: "StockFusionNotifIdentifier", content: content, trigger: triggerNotification)
        
        //schedule notification
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    

    
  
    
   
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

