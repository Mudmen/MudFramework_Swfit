//
//  MudLocationManager.swift
//  Travel
//
//  Created by TimTiger on 2/6/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit
import CoreLocation

class MudLocationManager: MudManager ,CLLocationManagerDelegate,UIAlertViewDelegate {
    
    var locationManager: CLLocationManager?
    var geocoder: CLGeocoder?
    
    //share instance
    class var defaultManager: MudLocationManager {
        struct Static {
            static var instance: MudLocationManager?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = MudLocationManager()
        }
        return Static.instance!
    }
    
    //MARK: - Public API
    func startUpdatingLocation() {
        self.setmanager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        } else {
            var alertView: UIAlertView = UIAlertView(title: MudLocalString.stringForKey("RequestLocationUpdatingTitle", tableName: "MudLocalization"), message: MudLocalString.stringForKey("RequestLocationUpdatingContent", tableName: "MudLocalization"), delegate: nil, cancelButtonTitle: MudLocalString.stringForKey("ButtonComfirmTitle", tableName: "MudLocalization"))
            alertView.show()
        }
    }
    
    func stopUpdateingLocation() {
        locationManager?.stopUpdatingLocation()
    }
    
    //MARK: - Private API
    private func setmanager() {
        if (locationManager == nil) {
            geocoder = CLGeocoder()
            locationManager = CLLocationManager()
            locationManager?.delegate = self;
            if (CurrentDeviceSystemVersion >= 8.0) {
                //                locationManager?.requestWhenInUseAuthorization()
                locationManager?.requestAlwaysAuthorization()
            }
            locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager?.activityType = CLActivityType.Fitness
        }
    }
    
    //MARK: - Delegate * self can't use it
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        geocoder?.reverseGeocodeLocation(locations[0] as CLLocation, completionHandler: { (resultArray, error) -> Void in
            if resultArray.count > 0 {
                var mark: CLPlacemark = resultArray[0] as CLPlacemark
                if (mark.country != nil && mark.country == MudLocalString.stringForKey("ChinaName", tableName: "MudLocalization")) {
                    NSLog("123")
                }
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.Authorized || status == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.startUpdatingLocation()
        } else {
            var alertView: UIAlertView = UIAlertView(title: MudLocalString.stringForKey("RequestLocationUpdatingTitle", tableName: "MudLocalization"), message: MudLocalString.stringForKey("RequestLocationUpdatingContent", tableName: "MudLocalization"), delegate: nil, cancelButtonTitle: MudLocalString.stringForKey("ButtonComfirmTitle", tableName: "MudLocalization"))
            alertView.show()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        geocoder?.reverseGeocodeLocation(newLocation, completionHandler: { (resultArray, error) -> Void in
            if resultArray.count > 0 {
                var mark: CLPlacemark = resultArray[0] as CLPlacemark
                if (mark.country != nil && mark.country == MudLocalString.stringForKey("ChinaName", tableName: "MudLocalization")) {
                    NSLog("123")
                }
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
    }

}

