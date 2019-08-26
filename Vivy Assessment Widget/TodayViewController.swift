//
//  TodayViewController.swift
//  Vivy Assessment Widget
//
//  Created by brandon maldonado alonso on 7/24/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import UIKit
import NotificationCenter
import Vivy_Assessment_Framework
import Kingfisher

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var regionalBlocksLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    let countriesContainer = CountriesContainer()
    let currentCountryDetector = CurrentCountryDetector()
    
    var country: Country? {
        didSet {
            setCountryData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateCountry), name: Notification.Name(rawValue: CurrentCountryNotification.updatedCountry.rawValue), object: nil)
        prepareExpandedSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if extensionContext?.widgetActiveDisplayMode == .compact {
            prepareCompactSize()
        } else if extensionContext?.widgetActiveDisplayMode == .expanded {
            prepareExpandedSize()
        }
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        self.countriesContainer.getAllCountries()
        completionHandler(NCUpdateResult.newData)
    }
    
    func prepareCompactSize() {
        self.currencyLabel.isHidden = true
        self.regionLabel.isHidden = true
        self.regionalBlocksLabel.isHidden = true
        self.languageLabel.isHidden = true
        setCountryData()
    }
    
    func prepareExpandedSize() {
        self.currencyLabel.isHidden = false
        self.regionLabel.isHidden = false
        self.regionalBlocksLabel.isHidden = false
        self.languageLabel.isHidden = false
        setCountryData()
    }
    
    func setCountryData() {
        if let country = country {
            nameLabel.text = country.name
            flagImageView.kf.setImage(with: country.imageURL)
            areaLabel.text = country.area == nil ? "No data available" : "Size: \(country.area!) km²"
            populationLabel.text = "Population: \(country.population) habitants"
            capitalLabel.text = "Capital: \(country.capital)"
            regionLabel.text = "Region: \(country.region)"
            var regionBlocks = "Region blocks:\n"
            country.regionalBlocs?.forEach{ regionBlocks.append($0.name + "\n") }
            regionalBlocksLabel.text = regionBlocks
            var languages = "Languages:\n"
            country.languages.forEach { languages.append($0.name + "\n")}
            languageLabel.text = languages
            var currencies = "Currencies:\n"
            country.currencies.forEach{ currencies.append( $0.name != nil ? $0.name! + "\n" : "" )}
            currencyLabel.text = currencies
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 300) : maxSize
    }
    
    @objc func didUpdateCountry() {
        if currentCountryDetector.currentCountryCode != "" {
            self.country = countriesContainer.getCurrentCountry(with: currentCountryDetector.currentCountryCode)
        }
    }
}
