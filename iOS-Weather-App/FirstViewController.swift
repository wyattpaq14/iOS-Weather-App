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
        
        
        
        var city = [String]()
        var zip = [String]()
        var state = [String]()
        
        var currentConditions = [String]()
        var tempature = [String]()
        var feelsLike = [String]()
        var humidity = [String]()
        var windspeed = [String]()
        var tempature = [String]()
        var winddir = [String]()
        
        
        let geonamesURL = URL(string: "http://api.geonames.org/findNearbyPostalCodesJSON?lat=\(String(format: "%.4f", latestLocation.coordinate.latitude))&lng=\(String(format: "%.4f", latestLocation.coordinate.longitude))&radius=10&username=wyattpaq14")
//        let url = URL(string: "http://api.geonames.org/findNearbyPostalCodesJSON?lat=42.041841&lng=-71.536786&radius=10&username=wyattpaq14")
        let task1 = URLSession.shared.dataTask(with: geonamesURL!) {(data, response, error) in
            
            
            
            do {
                if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let blogs = json["postalCodes"] as? [[String: Any]] {
                    for blog in blogs {
                        if let zipcode = blog["placeName"] as? String {
                            city.append(zipcode)
                        }
                        if let zipcode = blog["postalCode"] as? String {
                            zip.append(zipcode)
                        }
                        if let zipcode = blog["adminName1"] as? String {
                            state.append(zipcode)
                        }
                    }
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
            
            print("City", city[0])
            print("Zipcode :", zip[0])
            print("State :", state[0])
        }
        
        task1.resume()
        
//        now we have zip, lets get weather!
        
        
        
        
        
//        let weatherURL = URL(string: "http://api.geonames.org/findNearbyPostalCodesJSON?lat=\(String(format: "%.4f", latestLocation.coordinate.latitude))&lng=\(String(format: "%.4f", latestLocation.coordinate.longitude))&radius=10&username=wyattpaq14")
        let weatherURL = URL(string: "http://api.wunderground.com/api/ea3f17e608a0b764/conditions/q/CA/San_Francisco.json")
        let task2 = URLSession.shared.dataTask(with: weatherURL!) {(data, response, error) in
            
            
            
            do {
                if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let blogs = json["response"] as? [[String: Any]] {
                    for blog in blogs {
                        if let zipcode = blog["placeName"] as? String {
                            city.append(zipcode)
                        }
                        if let zipcode = blog["postalCode"] as? String {
                            zip.append(zipcode)
                        }
                    }
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
            
            print("City", city[0])
            print("Zipcode :", zip[0])
        }
        
        
        
        
        
        
        
        
        
        task2.resume()
        
        
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
    }
    


}

