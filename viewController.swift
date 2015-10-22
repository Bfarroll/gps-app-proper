//
//  ViewController.swift
//  workshop2
//
//  Created by Billy Farroll on 15/10/2015.
//  Copyright © 2015 Billy Farroll. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var MapView: MKMapView! 
    
   
    @IBOutlet weak var LatLabel: UILabel!
    @IBOutlet weak var LonLabel: UILabel!
    
    
    
    var lat:Float = 0.0
    var long:Float = 0.0
    var geocoder = CLGeocoder()
    let locationManager = CLLocationManager()
    
    
    
    @IBAction func LatSlider(sender: UISlider) {
        lat = sender.value
        LatLabel.text = "\(lat)"
    }
    
    
    @IBAction func LonSlider(sender: UISlider) {
        
        long = sender.value
        LonLabel.text = "\(long)"
    }
    
    
    
    @IBAction func GoButton(sender: UIButton) {
        
        let location = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        reverseGeocode(location)
        
        let location2d = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        MapView.setCenterCoordinate(location2d, animated: true)
        
        let annotations = MapView.annotations
        MapView.removeAnnotations(annotations)
        
        
        
        
    }
    
    
    func reverseGeocode(location: CLLocation) {
        if !geocoder.geocoding {
            geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                if placemarks!.count > 0 {
                    if let placemark = placemarks!.first {
                        print(placemark.country)
                        
                        let location2d = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.lat), longitude: CLLocationDegrees(self.long))
                        self.MapView.setCenterCoordinate(location2d, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location2d
                        annotation.title = placemark.country
                        self.MapView.addAnnotation(annotation)
                        self.MapView.selectAnnotation(annotation, animated: true)
                        
                        }
                } else {
                    print("Problem with the data received from geocoder")
                }
            })
        } else {
            print("Geocoder is already geocoding")
            return
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }


}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        
        //Something went wrong...
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocations = locations.last
        
        
        if let newLocations = newLocations {
            
            let markerLocation = CLLocation(latitude: CLLocationDegrees(lat),longitude: CLLocationDegrees(long))
            
            print(newLocations.distanceFromLocation(markerLocation))
            
        
            
            
        }
        
        
        
    }
    
    
}





