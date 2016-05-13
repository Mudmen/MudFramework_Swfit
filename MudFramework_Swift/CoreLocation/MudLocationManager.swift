//
//  MudLocationManager.swift
//  Travel
//
//  Created by TimTiger on 2/6/15.
//  Copyright (c) 2015 Mudmen. All rights reserved.
//

import UIKit
import CoreLocation

let UpdatingLocationGetUserLocationSuccess = "UpdatingLocationGetUserLocationSuccess"
let UpdatingLocationGetUserLocationNotAllowed = "UpdatingLocationGetUserLocationNotAllowed"
let UpdatingLocationGetUserLocationFailed = "UpdatingLocationGetUserLocationFailed"

//App Mode
enum UpdatingLocationMode : UInt {
    case getUserLocation        //获取用户位置
}

private let shareInstance = MudLocationManager()

class MudLocationManager: MudManager ,CLLocationManagerDelegate,UIAlertViewDelegate {
    
    lazy private var locationManager: CLLocationManager! = {
        let tlocationManager = CLLocationManager()
        tlocationManager.requestWhenInUseAuthorization()
        tlocationManager.desiredAccuracy = kCLLocationAccuracyBest
        tlocationManager.activityType = CLActivityType.Fitness
        return tlocationManager
    }()
    
   lazy var geocoder: CLGeocoder! = {
        let tgeocoder = CLGeocoder()
        return tgeocoder
    }()
    
    private var updatingMode = UpdatingLocationMode.getUserLocation
    
    var currentPlace: CLPlacemark? {
        didSet {
            if currentPlace != nil && self.updatingMode == .getUserLocation {
                NSNotificationCenter.defaultCenter().postNotificationName(UpdatingLocationGetUserLocationSuccess, object: nil)
            } else if currentPlace == nil {
                NSNotificationCenter.defaultCenter().postNotificationName(UpdatingLocationGetUserLocationFailed, object: nil)
            }
        }
    }
    
    var currentLocation: CLLocation? {
        didSet {
            
        }
    }
    
    //share instance
    class var defaultManager : MudLocationManager {
        return shareInstance
    }

    //MARK: Public API
    func startUpdatingLocationWithMode(mode: UpdatingLocationMode) {
        self.updatingMode = mode
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied {
            NSNotificationCenter.defaultCenter().postNotificationName(UpdatingLocationGetUserLocationNotAllowed, object: nil)
            return
        }
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
        } else {
            //The device does not support positioning
        }
    }
    
    func stopUpdateingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    //MARK: - Delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count < 1 {
            return
        }
        
        self.geocoder.reverseGeocodeLocation(locations.last! , completionHandler: { (resultArray, error) -> Void in
            if resultArray != nil && resultArray!.count > 0 {
                let mark: CLPlacemark = resultArray![0]
                if (mark.country != nil && mark.country == MudLocalString.stringForKey("ChinaName", tableName: "MudLocalization")) {
                }
                self.currentPlace = mark
            } else if error != nil {
                self.currentPlace = nil
            }
            self.currentLocation = locations.last
        })
        if self.updatingMode == .getUserLocation {
            self.stopUpdateingLocation()
        } else {
            //custom actions when in other mode
            self.stopUpdateingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        self.geocoder.reverseGeocodeLocation(newLocation, completionHandler: { (resultArray, error) -> Void in
            if resultArray != nil && resultArray!.count > 0 {
                let mark: CLPlacemark = resultArray![0] 
                if (mark.country != nil && mark.country == MudLocalString.stringForKey("ChinaName", tableName: "MudLocalization")) {
                }
            }
        })
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.stopUpdateingLocation()
    }

}

