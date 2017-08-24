//
//  MapViewController.swift
//  RideWithMeGood
//
//  Created by Martin Nadeau on 2017-07-17.
//  Copyright © 2017 Martin Nadeau. All rights reserved.
//

import UIKit
//import MapKit
import Mapbox
import CoreLocation
import RealmSwift

class MyCustomPointAnnotation: MGLPointAnnotation {
    var willUseImage: Bool = false
}

class MapViewController: UIViewController, UIBarPositioningDelegate, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MGLMapViewDelegate{
    
    //MKMapViewDelegate
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
   @IBOutlet weak var filterPicker: UIPickerView!
    @IBOutlet weak var infoRef: UIView!
    @IBOutlet weak var mapView: MGLMapView!
    
    // @IBOutlet weak var map: MKMapView!
    
    var filters = ["Coffee SHops","Bike Shops", "Bike Trails", "Rides & Events"]
    var manager: CLLocationManager?
    let distanceSpan:Double = 500
    var lastLocation:CLLocation?
    var venues:Results<Venue>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addObserver(self, forKeyPath: Selector("onVenuesUpdated:"), options: API.notifications.venuesUpdated, context: nil)\
        
       NotificationCenter.default.addObserver(self, selector: Selector(("onVenuesUpdated")), name: NSNotification.Name(rawValue: API.notifications.venuesUpdated), object: nil);
        
        self.filterPicker.delegate = self
        self.filterPicker.dataSource = self
        
        filterPicker.isHidden = true
        
        //manager = CLLocationManager()
        //manager.delegate = self
        //manager.desiredAccuracy = kCLLocationAccuracyBest
        //manager.requestWhenInUseAuthorization()
        //manager.distanceFilter = 50
        //manager.startUpdatingLocation()
        
        mapView.delegate = self
        
        let point = MyCustomPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.552437, longitude: -73.556177)
        point.title = "Velo Montreal"
        point.subtitle = "3880 Rachel Est (Bourbonnière), Montreal"

        let point2 = MyCustomPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.533458, longitude: -73.567179)
        point.title = "iBike"
        point.subtitle = "2127 Rachel St. E (Parthenais), Montreal"
        
        let point3 = MyCustomPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.485812, longitude: -73.580602)
        point.title = "Cycle Technique"
        point.subtitle = "788 av. Atwater (at rue Saint-Antoine E), Montreal"
        
        let myPlaces = [point, point2, point3]

        mapView.addAnnotations(myPlaces)
//        mapView.addAnnotation(point2)
//        mapView.addAnnotation(point3)
        mapView.userTrackingMode = .follow
        
        infoRef.isHidden = true
        
    }
    
    // Hide Keyboard by return Button
    func textFieldShouldReturn(_ userNameTF: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // Hide Keyboard Gesture
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if manager == nil {
            manager = CLLocationManager()
            
            manager!.delegate = self
            manager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            manager!.requestAlwaysAuthorization()
            manager!.distanceFilter = 50
            manager!.startUpdatingLocation()
        }
    }
    
    
//    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
//        if annotation.isKind(of: MGLUserLocation.self)
//        {
//            return nil
//        }
//        
//        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationIdentifier")
//        
//        if view == nil
//        {
//            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationIdentifier")
//        }
//        
//        view?.canShowCallout = true
//        
//        return view
//    }
        
//        guard annotation is MGLPointAnnotation else {
//            return nil
//        }
//    
//        let reuseIdentifier = "\(annotation.coordinate.longitude)"
//        
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//        
//        if annotationView == nil {
//            annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
//            
//        }
//        
//        return annotationView
//    }

    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        
        
        return true
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition{
        return .topAttached;
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filters[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filterButton.setTitle(filters[row], for: .normal)
        filterPicker.isHidden = true;
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        filterPicker.isHidden = false
        return false
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        filterPicker.isHidden = false
    }
   
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
//            mapView.setRegion(region, animated: true)
            let center = CLLocationCoordinate2D(latitude: (manager.location?.coordinate.latitude)!, longitude: (manager.location?.coordinate.longitude)!)
            mapView.setCenter(center, zoomLevel: 15, animated: true)
            
            refreshVenues(location: newLocation, getDataFromFoursquare: true)
        }
    }
    
    func refreshVenues(location: CLLocation?, getDataFromFoursquare:Bool = false)
    {
//        if filterPicker .selectedRow(inComponent: 0) == 0{
        
        
        if location != nil
        {
            lastLocation = location
        }
        
        if let location = lastLocation
        {
            if getDataFromFoursquare == true
            {
                FourSquareAPI.sharedInstance.getCoffeeShopsWithLocation(location: location)
            }
            
            let realm = try! Realm()
            
            venues = realm.objects(Venue.self)
            
            for venue in venues!
            {
                let annotation = Annotation(title: venue.name, subtitle: venue.address, coordinate: CLLocationCoordinate2D(latitude: Double(venue.latitude), longitude: Double(venue.longitude)))
                
                mapView?.addAnnotation(annotation)
                }
            }
        }
//        if filterPicker .selectedRow(inComponent: 0) == 1{
//            
//            
//            if location != nil
//            {
//                lastLocation = location
//            }
//            
//            if let location = lastLocation
//            {
//                if getDataFromFoursquare == true
//                {
//                    FourSquareAPI.sharedInstance.getBikeShopsWithLocation(location: location)
//                }
//                
//                let realm = try! Realm()
//                
//                venues = realm.objects(Venue.self)
//                
//                for venue in venues!
//                {
//                    let annotation = Annotation(title: venue.name, subtitle: venue.address, coordinate: CLLocationCoordinate2D(latitude: Double(venue.latitude), longitude: Double(venue.longitude)))
//                    
//                    mapView?.addAnnotation(annotation)
//                }
//            }
//        }
        
//        if filterPicker .selectedRow(inComponent: 0) == 2{
//            
//            
//            if location != nil
//            {
//                lastLocation = location
//            }
//            
//            if let location = lastLocation
//            {
//                if getDataFromFoursquare == true
//                {
//                    FourSquareAPI.sharedInstance.getBikeTrailsWithLocation(location: location)
//                }
//                
//                let realm = try! Realm()
//                
//                venues = realm.objects(Venue.self)
//                
//                for venue in venues!
//                {
//                    let annotation = Annotation(title: venue.name, subtitle: venue.address, coordinate: CLLocationCoordinate2D(latitude: Double(venue.latitude), longitude: Double(venue.longitude)))
//                    
//                    mapView?.addAnnotation(annotation)
//                }
//            }
//        }
//    }
    
    func onVenuesUpdated(notification:NSNotification)
    {
        refreshVenues(location: nil)
    }
}
