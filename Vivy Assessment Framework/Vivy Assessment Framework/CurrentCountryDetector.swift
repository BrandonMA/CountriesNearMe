//
//  Country.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/23/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import Foundation
import CoreLocation

public enum CurrentCountryNotification: String {
    case updatedCountry
}

public class CurrentCountryDetector: NSObject {
    public let locationManager = CLLocationManager()
    public var currentCountryCode: String = ""
    
    public override init() {
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    public func getCountry(from location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { [unowned self] (placemarks, error) in
            if let error = error {
                print(error)
            } else if let placemarks = placemarks, let currentCountry = placemarks.first?.isoCountryCode {
                if currentCountry != self.currentCountryCode {
                    self.currentCountryCode = currentCountry
                    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: CurrentCountryNotification.updatedCountry.rawValue)))
                }
            }
        }
    }
}

extension CurrentCountryDetector: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let location = manager.location else { return }
        getCountry(from: location)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        getCountry(from: location)
    }
}
