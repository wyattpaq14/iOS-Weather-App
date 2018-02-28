//
//  FirstViewController.swift
//  iOS-Weather-App
//
//  Created by Paquin, Wyatt A on 2/27/18.
//  Copyright © 2018 Paquin, Wyatt A. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    
    
    @IBOutlet weak var lblLocation: UILabel!

    
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
        
        
        
        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        let latestLocation: CLLocation = locations[locations.count - 1]
        
       
        if startLocation == nil {
            startLocation = latestLocation
        }
        
//        lblLocation.text = String(format: "%.4f", latestLocation.coordinate.latitude)
        
//        let distanceBetween: CLLocationDistance =
//            latestLocation.distance(from: startLocation)
//
//        distance.text = String(format: "%.2f", distanceBetween)
        
        
        
        
        
//        let url = URL(string: "http://api.geonames.org/findNearbyPostalCodesJSON?lat=\(String(format: "%.4f", latestLocation.coordinate.latitude))&lng=\(String(format: "%.4f", latestLocation.coordinate.longitude))&radius=10&username=wyattpaq14")
        let url = URL(string: "http://api.geonames.org/findNearbyPostalCodesJSON?lat=47&lng=9&radius=10&username=wyattpaq14")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//            self.lblLocation.text = String(data: data!, encoding: .utf8)
//            self.lblLocation.text = response?.description
//            print(String(data: data!, encoding: .utf8))
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            json[
        }
        
        task.resume()
        
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
    }


}

