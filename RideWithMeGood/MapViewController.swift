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

class MapViewController: UIViewController, UIBarPositioningDelegate, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MGLMapViewDelegate{
    
    //MKMapViewDelegate
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
   @IBOutlet weak var filterPicker: UIPickerView!
    @IBOutlet weak var infoRef: UIView!
    @IBOutlet weak var mapView: MGLMapView!
    
    // @IBOutlet weak var map: MKMapView!
    
    var filters = ["Bike Shops", "Events", "Rides"]
    var manager: CLLocationManager?
    let distanceSpan:Double = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 45.4882780469, longitude: -73.5837409984)
        point.title = "Lasalle College"
        point.subtitle = "2000 Saint-Catherine St W, Montreal, QC H3H 2T3"
        
        mapView.addAnnotation(point)
        
        infoRef.isHidden = true
        
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
        }
    }
}
