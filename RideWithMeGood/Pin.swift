//Pin.swift

//
//  Pin.swift
//  RideWithMeGood
//
//  Created by Martin Nadeau on 2017-07-16.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
