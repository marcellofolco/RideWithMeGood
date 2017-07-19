//
//  MapViewController.swift
//  RideWithMeGood
//
//  Created by Martin Nadeau on 2017-07-17.
//  Copyright © 2017 Martin Nadeau. All rights reserved.
//

import UIKit
import MapKit
import Mapbox
import CoreLocation

class MapViewController: UIViewController, UIBarPositioningDelegate, MKMapViewDelegate, CLLocationManagerDelegate, MGLMapViewDelegate{
    
    @IBOutlet weak var navBar: UINavigationBar!
   // @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var infoRef: UIView!
    @IBOutlet weak var mapView: MGLMapView!
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.distanceFilter = 50
        manager.startUpdatingLocation()
        
        mapView.delegate = self
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.4882780469, longitude: -73.5837409984)
        point.title = "Lasalle College"
        point.subtitle = "2000 Saint-Catherine St W, Montreal, QC H3H 2T3"
        
        mapView.addAnnotation(point)
        
        infoRef.isHidden = true
        
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        
        return true
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition{
        return .topAttached;
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        
        let latitude:CLLocationDegrees = userLocation.coordinate.latitude
        
        let longitude:CLLocationDegrees = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.05
        
        let lonDelta:CLLocationDegrees = 0.05
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        //map.setRegion(region, animated: false)
        
        let pin = MKPointAnnotation()
        pin.coordinate.latitude = userLocation.coordinate.latitude
        pin.coordinate.longitude = userLocation.coordinate.longitude
        pin.title = "Your Movement Line"
        //map.addAnnotation(pin)
        
    }
    
}
