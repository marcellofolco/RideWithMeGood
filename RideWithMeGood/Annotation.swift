//
//  Annotation.swift
//  RideWithMeGood
//
//  Created by Marcello Folco on 2017-08-05.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import Foundation
import Mapbox

class Annotation: NSObject, MGLAnnotation
{
    let title:String?
    let subtitle:String?
    let coordinate: CLLocationCoordinate2D
    
    
    init(title: String?, subtitle:String?, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
}
