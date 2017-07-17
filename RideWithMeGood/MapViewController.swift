//
//  MapViewController.swift
//  RideWithMeGood
//
//  Created by Marcello Folco on 2017-07-17.
//  Copyright © 2017 Marcello Folco. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIBarPositioningDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition{
        return .topAttached;
    }
    
}
