//
//  CurrentCountryController.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/24/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import UIKit
import SwifterUI
import Vivy_Assessment_Framework

class CountryController: SFViewController {
    
    var country: Country? {
        didSet {
            setCountryData()
        }
    }
    
    lazy var countryView: CountryView = {
        let view = CountryView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(country: Country?) {
        self.country = country
        super.init(automaticallyAdjustsColorStyle: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sfview.addSubview(countryView)
        countryView.clipSides()
        setCountryData()
    }
    
    override func prepare(navigationController: UINavigationController) {
        super.prepare(navigationController: navigationController)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setCountryData() {
        if let country = country {
            countryView.nameLabel.text = country.name
            countryView.flagImageView.kf.setImage(with: country.imageURL) { (result) in
                switch result {
                case .success: break
                case .failure: self.countryView.flagImageView.isHidden = true
                }
            }
            countryView.areaLabel.text = country.area == nil ? "No data available" : "Size: \(country.area!) km²"
            countryView.populationLabel.text = "Population: \(country.population) habitants"
            countryView.capitalLabel.text = "Capital: \(country.capital)"
            countryView.regionLabel.text = "Region: \(country.region)"
            var regionBlocks = "Region blocks:\n"
            country.regionalBlocs?.forEach{ regionBlocks.append($0.name + "\n") }
            countryView.regionalBlocksLabel.text = regionBlocks
            var languages = "Languages:\n"
            country.languages.forEach { languages.append($0.name + "\n")}
            countryView.languageLabel.text = languages
            var currencies = "Currencies:\n"
            country.currencies.forEach{ currencies.append( $0.name != nil ? $0.name! + "\n" : "" )}
            countryView.currencyLabel.text = currencies
            let latitudeString = country.latitude != nil ? "\(country.latitude!)" : "Not available"
            countryView.latitudeLabel.text = "Latitude: " + latitudeString
            let longitudeString = country.longitude != nil ? "\(country.longitude!)" : "Not available"
            countryView.longitudeLabel.text = "Longitude: " + longitudeString
            if let location = country.location {
                countryView.mapView.setCenter(location.coordinate, animated: true)
            } else {
                countryView.mapView.isHidden = true
            }
        }
    }
}
