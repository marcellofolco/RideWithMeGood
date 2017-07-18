//
//  User.swift
//  RideWithMeGood
//
//  Created by Martin Nadeau on 2017-07-17.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct  User {
    
    var username: String!
    var email: String?
    var photoURL: String!

    var uid: String!
    var ref: FirebaseDatabaseReference?
    var key: String!
    
    
    init(snapchot: FIRDataSnapshot) {
        
        key = snapshot.key
        ref = snapshot.ref
        username = (snapshot.value! as! NSDictionary)["username"] as! String
        email = (snapshot.value! as! NSDictionary)["email"] as? String
        uid = snapshot.value! as! NSDictionary)["uid"] as! String
        photoURL = snapshot.value! as! NSDictionary)["photoURL"] as! String

        

    }
    
}
