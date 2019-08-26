//
//  Country.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/24/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import Foundation
import CoreLocation

public struct Country: Codable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name.hashValue)
    }
    
    public let name: String
    public let alpha2Code: String
    public let population: Int
    public let capital: String
    public let region: String
    public let area: Float?
    public let regionalBlocs: Array<RegionalBlock>?
    public let languages: Array<Language>
    public let currencies: Array<Currency>
    public let latlng: Array<Float>
    
    public var latitude: CLLocationDegrees? {
        return latlng.count > 0 ? CLLocationDegrees(latlng[0]) : nil
    }
    
    public var longitude: CLLocationDegrees? {
        return latlng.count > 0 ? CLLocationDegrees(latlng[1]) : nil
    }
    
    public var imageURL: URL? {
        return URL(string: "http://flagpedia.net/data/flags/normal/" + alpha2Code.lowercased() + ".png")
    }
    
    private var cachedDistance: CLLocationDistance?
    public var location: CLLocation? {
        if let latitude = latitude, let longitude = longitude {
            return CLLocation(latitude: latitude, longitude: longitude)
        } else {
            return nil
        }
    }
    
    public func distance(from location: CLLocation) -> CLLocationDistance? {
        if cachedDistance == nil, let ownLocation = self.location {
            return ownLocation.distance(from: location)
        } else {
            return cachedDistance
        }
    }
}
