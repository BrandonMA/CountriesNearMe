//
//  CountriesContainer.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/24/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import Foundation

public protocol CountriesContainerDelegate: class {
    func didReceiveCountries()
    func didFailFetchingCountries(error: Error)
}

public class CountriesContainer {
    
    public static let baseURL = "https://restcountries.eu/rest/v2/"
    public var countries: Array<Country> = []
    public var delegate: CountriesContainerDelegate?
    
    public init() {
        getAllCountries()
    }
    
    public func getAllCountries() {
        guard let url = URL(string: CountriesContainer.baseURL + "all") else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
            do {
                if let error = error {
                    throw error
                } else if let data = data {
                    let decoder = JSONDecoder()
                    self.countries = try decoder.decode(Array<Country>.self, from: data)
                    self.delegate?.didReceiveCountries()
                }
            } catch let error {
                print(error)
                self.delegate?.didFailFetchingCountries(error: error)
            }
        }
        dataTask.resume()
    }
    
    public func getCurrentCountry(with code: String) -> Country? {
        return countries.first(where: { (country) -> Bool in
            return country.alpha2Code.lowercased().contains(code.lowercased())
        })
    }
}
