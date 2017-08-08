//
//  FourSquareAPI.swift
//  RideWithMeGood
//
//  Created by Marcello Folco on 2017-08-04.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import Foundation
import QuadratTouch
import RealmSwift
import Mapbox

struct API {
    struct notifications {
        static let venuesUpdated = "venues updated"
    }
}

class FourSquareAPI{
    static let sharedInstance = FourSquareAPI()
    var session:Session?
    
    init(){
        let client = Client(clientID: "MADNXONYMZPCTPDCPYZXK2KRTZSZCE35BQCYMSTWAQBA0CH3", clientSecret: "AFFIKYVDICUEIMVPRKA52KAQNWMGXTV1FIBAKIYNZTZET451", redirectURL: "")
        let configuration = Configuration(client: client)
        Session.setupSharedSessionWithConfiguration(configuration)
        
        self.session = Session.sharedSession()
        
    }
    
    func getCoffeeShopsWithLocation(location:CLLocation)
    {
        if let session = self.session
        {
            var parameters = location.parameters()
            
            parameters += [Parameter.categoryId: "4bf58dd8d48988d1e0931735"]
            parameters += [Parameter.radius: "2000"]
            parameters += [Parameter.limit: "50"]
            
            let searchTask = session.venues.search(parameters)
            {
                (result) -> Void in
                
                if let response = result.response
                {
                    if let venues = response["venues"] as? [[String: AnyObject]]
                    {
                        autoreleasepool
                            {
                                let realm = try! Realm()
                                realm.beginWrite()
                                
                                for venue:[String: AnyObject] in venues
                                {
                                    let venueObject:Venue = Venue()
                                    
                                    if let id = venue["id"] as? String
                                    {
                                        venueObject.id = id
                                    }
                                    
                                    if let name = venue["name"] as? String
                                    {
                                        venueObject.name = name
                                    }
                                    
                                    if  let location = venue["location"] as? [String: AnyObject]
                                    {
                                        if let longitude = location["lng"] as? Float
                                        {
                                            venueObject.longitude = longitude
                                        }
                                        
                                        if let latitude = location["lat"] as? Float
                                        {
                                            venueObject.latitude = latitude
                                        }
                                        
                                        if let formattedAddress = location["formattedAddress"] as? [String]
                                        {
                                            venueObject.address = formattedAddress.joined(separator: " ")
                                        }
                                    }
                                    
                                    realm.add(venueObject, update: true)
                                }
                                
                                do {
                                    try realm.commitWrite()
                                    print("Committing write")
                                }
                                catch (let e)
                                {
                                    print("Commit failed ? \(e)")
                                }
                        }
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: API.notifications.venuesUpdated), object: nil)
                    }
                }
            }
            
            searchTask.start()
        }
    }
    
    func getBikeShopsWithLocation(location:CLLocation)
    {
        if let session = self.session
        {
            var parameters = location.parameters()
            
            parameters += [Parameter.categoryId: "4bf58dd8d48988d115951735"]
            parameters += [Parameter.radius: "2000"]
            parameters += [Parameter.limit: "50"]
            
            let searchTask = session.venues.search(parameters)
            {
                (result) -> Void in
                
                if let response = result.response
                {
                    if let venues = response["venues"] as? [[String: AnyObject]]
                    {
                        autoreleasepool
                            {
                                let realm = try! Realm()
                                realm.beginWrite()
                                
                                for venue:[String: AnyObject] in venues
                                {
                                    let venueObject:Venue = Venue()
                                    
                                    if let id = venue["id"] as? String
                                    {
                                        venueObject.id = id
                                    }
                                    
                                    if let name = venue["name"] as? String
                                    {
                                        venueObject.name = name
                                    }
                                    
                                    if  let location = venue["location"] as? [String: AnyObject]
                                    {
                                        if let longitude = location["lng"] as? Float
                                        {
                                            venueObject.longitude = longitude
                                        }
                                        
                                        if let latitude = location["lat"] as? Float
                                        {
                                            venueObject.latitude = latitude
                                        }
                                        
                                        if let formattedAddress = location["formattedAddress"] as? [String]
                                        {
                                            venueObject.address = formattedAddress.joined(separator: " ")
                                        }
                                    }
                                    
                                    realm.add(venueObject, update: true)
                                }
                                
                                do {
                                    try realm.commitWrite()
                                    print("Committing write")
                                }
                                catch (let e)
                                {
                                    print("Commit failed ? \(e)")
                                }
                        }
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: API.notifications.venuesUpdated), object: nil)
                    }
                }
            }
            
            searchTask.start()
        }
    }
    
    func getBikeTrailsWithLocation(location:CLLocation)
    {
        if let session = self.session
        {
            var parameters = location.parameters()
            
            parameters += [Parameter.categoryId: "56aa371be4b08b9a8d57355e"]
            parameters += [Parameter.radius: "2000"]
            parameters += [Parameter.limit: "50"]
            
            let searchTask = session.venues.search(parameters)
            {
                (result) -> Void in
                
                if let response = result.response
                {
                    if let venues = response["venues"] as? [[String: AnyObject]]
                    {
                        autoreleasepool
                            {
                                let realm = try! Realm()
                                realm.beginWrite()
                                
                                for venue:[String: AnyObject] in venues
                                {
                                    let venueObject:Venue = Venue()
                                    
                                    if let id = venue["id"] as? String
                                    {
                                        venueObject.id = id
                                    }
                                    
                                    if let name = venue["name"] as? String
                                    {
                                        venueObject.name = name
                                    }
                                    
                                    if  let location = venue["location"] as? [String: AnyObject]
                                    {
                                        if let longitude = location["lng"] as? Float
                                        {
                                            venueObject.longitude = longitude
                                        }
                                        
                                        if let latitude = location["lat"] as? Float
                                        {
                                            venueObject.latitude = latitude
                                        }
                                        
                                        if let formattedAddress = location["formattedAddress"] as? [String]
                                        {
                                            venueObject.address = formattedAddress.joined(separator: " ")
                                        }
                                    }
                                    
                                    realm.add(venueObject, update: true)
                                }
                                
                                do {
                                    try realm.commitWrite()
                                    print("Committing write")
                                }
                                catch (let e)
                                {
                                    print("Commit failed ? \(e)")
                                }
                        }
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: API.notifications.venuesUpdated), object: nil)
                    }
                }
            }
            
            searchTask.start()
        }
    }


    
    
}

extension CLLocation
{
    func parameters() -> Parameters
    {
        let ll      = "\(self.coordinate.latitude),\(self.coordinate.longitude)"
        let llAcc   = "\(self.horizontalAccuracy)"
        let alt     = "\(self.altitude)"
        let altAcc  = "\(self.verticalAccuracy)"
        let parameters = [
            Parameter.ll:ll,
            Parameter.llAcc:llAcc,
            Parameter.alt:alt,
            Parameter.altAcc:altAcc
        ]
        return parameters
    }
}
