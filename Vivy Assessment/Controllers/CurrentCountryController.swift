//
//  CurrentCountryController.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/24/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import Foundation
import Vivy_Assessment_Framework

class CurrentCountryController: CountryController {
    
    let currentCountryDetector: CurrentCountryDetector
    let countriesContainer: CountriesContainer
    
    init(currentCountryDetector: CurrentCountryDetector, countriesContainer: CountriesContainer) {
        self.currentCountryDetector = currentCountryDetector
        self.countriesContainer = countriesContainer
        super.init(country: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateCountry), name: Notification.Name(rawValue: CurrentCountryNotification.updatedCountry.rawValue), object: nil)
    }
    
    @objc func didUpdateCountry() {
        if currentCountryDetector.currentCountryCode != "" {
            country = countriesContainer.getCurrentCountry(with: currentCountryDetector.currentCountryCode)
        }
    }
    
}
