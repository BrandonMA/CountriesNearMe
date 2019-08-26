//
//  ViewController.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/23/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import UIKit
import SwifterUI
import Kingfisher
import MapKit
import Vivy_Assessment_Framework

extension Country: SFDataType {
    public static func compareContent(_ a: Country, _ b: Country) -> Bool {
        return a.name == b.name
    }
    
    public static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }
}

class ListViewController: SFViewController, CountriesContainerDelegate {
    
    let adapter = SFTableAdapter<Country, ListViewCell, SFTableViewHeaderView, SFTableViewFooterView>()
    let countriesContainer: CountriesContainer
    let currentCountryDetector: CurrentCountryDetector
    let dataManager = SFDataManager<Country>()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["Name", "Capital", "Language"]
        searchController.searchBar.delegate = self
        return searchController
    }()

    lazy var listView: SFTableView = {
        let view = SFTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(currentCountryDetector: CurrentCountryDetector, countriesContainer: CountriesContainer) {
        self.currentCountryDetector = currentCountryDetector
        self.countriesContainer = countriesContainer
        super.init(automaticallyAdjustsColorStyle: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        sfview.addSubview(listView)
        listView.clipTop(to: .top, useSafeArea: false)
        listView.clipSides(exclude: [.top])
        adapter.configure(tableView: listView, dataManager: dataManager)
        adapter.delegate = self
        dataManager.forceUpdate(data: [countriesContainer.countries])
        countriesContainer.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCountries), name: Notification.Name(rawValue: CurrentCountryNotification.updatedCountry.rawValue), object: nil)
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
    }
    
    override func prepare(navigationController: UINavigationController) {
        super.prepare(navigationController: navigationController)
        navigationItem.searchController = searchController
        navigationItem.title = "Country List"
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.prefersLargeTitles = true
    }

    @objc func didReceiveCountries() {
        if let currentLocation = currentCountryDetector.locationManager.location {
            countriesContainer.countries.sort { (firstCountry, nextCountry) -> Bool in
                guard let firstDistance = firstCountry.distance(from: currentLocation) else { return false }
                guard let nextDistance = nextCountry.distance(from: currentLocation) else { return true }
                return firstDistance < nextDistance
            }
        }
        
        DispatchQueue.main.async {
            self.dataManager.forceUpdate(data: [self.countriesContainer.countries])
        }
    }
    
    func didFailFetchingCountries(error: Error) {
        print(error)
    }
}

extension ListViewController: SFTableAdapterDelegate {
    func prepareCell<DataType>(_ cell: SFTableViewCell, at indexPath: IndexPath, with item: DataType) where DataType : SFDataType {
        guard let cell = cell as? ListViewCell, let country = item as? Country else { return }
        cell.flagImageView.kf.setImage(with: country.imageURL, options: [
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
        cell.nameLabel.text = country.name
        cell.populationLabel.text = "\(country.population) habitants"
        cell.areaLabel.text = country.area == nil ? "No data available" : "\(country.area!) km²"
    }
    
    func didSelectCell<DataType>(with item: DataType, at indexPath: IndexPath, tableView: SFTableView) where DataType : SFDataType {
        guard let country = item as? Country else { return }
        let controller = CountryController(country: country)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func performSearch() {
        guard let text = searchController.searchBar.text else { return }
        
        if text == "" {
            adapter.clearSearch()
        } else {
            adapter.search { (country) -> Bool in
                if searchController.searchBar.selectedScopeButtonIndex == 0 {
                    return country.name.lowercased().contains(text.lowercased())
                } else if searchController.searchBar.selectedScopeButtonIndex == 1 {
                    return country.capital.lowercased().contains(text.lowercased())
                } else {
                    return country.languages.contains(where: { (language) -> Bool in
                        return language.name.lowercased().contains(text.lowercased())
                    })
                }
            }
        }
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        performSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        performSearch()
    }
}
