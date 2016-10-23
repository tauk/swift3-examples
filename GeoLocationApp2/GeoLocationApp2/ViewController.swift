//
//  ViewController.swift
//  GeoLocationApp2
//
//  Created by Tauseef Kamal on 10/19/16.
//  Copyright © 2016 Tauseef Kamal. All rights reserved.
//

import UIKit
import CoreLocation //1.import CoreLocation

//2.make the ViewController inherit from CLLocationManagerDelegate
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    
    //3. Create an instance of CLLocationManager
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //8.get the current location
        getCurrentLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //6. add this method to the class
    func getCurrentLocation() {
        //6.1 set the delegate to self
        locationManager.delegate = self
        
        //6.2 set the location accuracy to best
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //6.3 start to get the the location coordinates
        locationManager.startUpdatingLocation()
    }
    
    
    //7.implement CLLocationManagerDelegate method to get the list of recent locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //we get array of CLLocation objects from the location manager - we will use the last location
        let lastLocation = locations.last!
        
        //from the last CLLocation object in the array get the latitude and longitude
        dataLabel.text = "\(lastLocation.coordinate.latitude)  \(lastLocation.coordinate.longitude)"
    }
    
    
}

