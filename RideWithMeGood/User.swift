//
//  User.swift
//  RideWithMeGood
//
//  Created by User on 2017-07-27.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit

class User: NSObject {
    
    
    var firstName: String
    var lastName: String
    var city: String
    var picture:String
    var email:String
    
    
    override init(){
        
        self.firstName = ""
        self.lastName = ""
        self.city = ""
        self.picture = ""
        self.email = ""
        
        
    }
    
    
    
    init(firstName: String,lastName: String,city:String,picture:String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.city = city
        self.picture = picture
        self.email = ""
        
    }
    
    init(firstName: String,lastName: String,email:String,picture:String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.picture = picture
        self.city = ""
        
    }
    
    
    
    
    
    func first_Name() -> String {
        
        return firstName
        
    }
    
    func last_Name() -> String {
        
        return lastName
        
    }
    
    func user_city() -> String {
        
        return city
        
    }
    
    func user_picture() -> String {
        
        return picture
        
    }
    
    
    
    
    func currentUser() -> String{ //return a string with the current User
        return firstName + "  " + lastName + "\n"+city+"\n"+picture
    }
    
    
    func setFirstName(firstName:String) -> Void{
        self.firstName = firstName
    }
    
    func setLasttName(lastName:String) -> Void{
        self.lastName = lastName
    }
    
    func setCity(city:String) -> Void{
        self.city = city
    }
    
    func setPicture(picture:String) -> Void{
        self.picture = picture
    }
    
    func setEmail(email:String) -> Void{
        self.email = email
    }
    
    

    
    
    
    

}
