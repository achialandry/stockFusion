//
//  UserModel.swift
//  StockFusion
//
//  Created by Landry Achia Ndong on 2018-08-02.
//  Copyright © 2018 Landry Achia Ndong. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseInstanceID

struct Users {
    
    let uid: String
    let email: String
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
