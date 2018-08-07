//
//  TrackStockItem.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-08-02.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct TrackStockItem {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let addedByUser: String
    var stoppedTracking: Bool
    
    init(name: String, addedByUser: String, stoppedTracking: Bool, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.stoppedTracking = stoppedTracking
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let addedByUser = value["addedByUser"] as? String,
            let stoppedTracking = value["stoppedTracking"] as? Bool else {
                return nil
        }

        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.addedByUser = addedByUser
        self.stoppedTracking = stoppedTracking
    }
    
    //helper function to turn data into dictionary before storing to database
    func toAnyObject() -> Any {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "stoppedTracking": stoppedTracking
        ]
    }
}
