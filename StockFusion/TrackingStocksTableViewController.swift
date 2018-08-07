//
//  TrackingStocksTableViewController.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-08-02.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import UserNotifications


class TrackingStocksTableViewController: UITableViewController {
    
    // MARK: Constants
    let listToUsers = "ListToUsers"
    
    // MARK: Properties
    var items: [TrackStockItem] = []
    var user: Users!
    var userStockTrackBarButtonItem: UIBarButtonItem!
    

    
    let ref = Database.database().reference(withPath: "stockfusionios")
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Track Stock Prices"
        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        userStockTrackBarButtonItem = UIBarButtonItem(title: "Track Stock",
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(userTrackStockButtonDidTouch))
        userStockTrackBarButtonItem.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = userStockTrackBarButtonItem
        
        
        //setting user in db
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = Users(authData: user)
            
            
        }
        
        
        
        //retrieve data in firebase using an asynchronous listener to a reference
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
            
            //synchronizing data from firebase db to tableview
            var newItems: [TrackStockItem] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let trackStockItem = TrackStockItem(snapshot: snapshot) {
                        newItems.append(trackStockItem)
                }
            }
            
            self.items = newItems
            self.tableView.reloadData()
        })
        
        
    }
    
    // MARK: UITableView Delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let stockItem = items[indexPath.row]
        
        cell.textLabel?.text = stockItem.name
        cell.detailTextLabel?.text = stockItem.addedByUser
        
        toggleCellCheckbox(cell, isCompleted: stockItem.stoppedTracking)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let trackedStockItem = items[indexPath.row]
            trackedStockItem.ref?.removeValue()
            
        }
    }
    
    //here the user can stop tracking a stock of their choice
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let stockItem = items[indexPath.row]
        let toggledCompletion = !stockItem.stoppedTracking
        
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        stockItem.ref?.updateChildValues(["stoppedTracking": toggledCompletion])
        tableView.reloadData()
    }
    
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .gray
            cell.detailTextLabel?.textColor = .gray
        }
    }
    
    // MARK: Add Item so that it syncs or gets all user data from backend and synchronizes it
    
    @IBAction func addTrackingBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Stock",
                                      message: "Add a stock to Track",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
                let text = textField.text else {return}
            
            
            let stockItem = TrackStockItem(name: text,
                                           addedByUser: self.user.email,
                                           stoppedTracking: false)
            
            //referencing to objects on firebase db
            let stockItemRef = self.ref.child(text.lowercased())
            
            //pushing value up to backend for key
            stockItemRef.setValue(stockItem.toAnyObject())
            
            //since this is the tab view controller all notification will be handled in here
            let content = UNMutableNotificationContent()
            content.title = "Stock Fusion Price Change 🔥"
            content.body = "There is a change in price for \(text), New changes to stock price open on some stock. Check now!"
            content.sound = UNNotificationSound.default()
            
            //setting a trigger to trigger the notification after every 1 minute (10 seconds for testing purpose)
            let triggerNotification = UNTimeIntervalNotificationTrigger(timeInterval: 140, repeats: false)
            
            //setting an identifier for this notification
            let request = UNNotificationRequest(identifier: "StockFusionPrice", content: content, trigger: triggerNotification)
            
            //schedule notification
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    

    
    @objc func userTrackStockButtonDidTouch() {
//        performSegue(withIdentifier: listToUsers, sender: nil)
        let alert = UIAlertController(title: "Stock",
                                      message: "Add a stock to Track",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let textField = alert.textFields?.first,
                let text = textField.text else {return}
            
            
            let stockItem = TrackStockItem(name: text,
                                           addedByUser: self.user.email,
                                           stoppedTracking: false)
            
            //referencing to objects on firebase db
            let stockItemRef = self.ref.child(text.lowercased())
            
            //pushing value up to backend for key
            stockItemRef.setValue(stockItem.toAnyObject())
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
