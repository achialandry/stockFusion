//
//  UserModel.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-08-02.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
