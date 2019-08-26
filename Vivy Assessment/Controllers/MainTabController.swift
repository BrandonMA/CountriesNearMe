//
//  MainTabController.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/23/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import UIKit
import SwifterUI
import Vivy_Assessment_Framework

class MainTabBarController: SFTabBarController {
    
    let currentCountryDetector: CurrentCountryDetector
    let countriesContainer: CountriesContainer
    
    lazy var listViewController: SFNavigationController = { [unowned self] in
        let controller = ListViewController(currentCountryDetector: self.currentCountryDetector, countriesContainer: self.countriesContainer)
        let navigationController = SFNavigationController(rootViewController: controller)
        navigationController.tabBarItem = UITabBarItem(title: "Countries", image: UIImage(named: "map-outline"), selectedImage: UIImage(named: "map-filled"))
        return navigationController
    }()
    
    lazy var currentCountryController: CountryController = { [unowned self] in
        let controller = CurrentCountryController(currentCountryDetector: self.currentCountryDetector, countriesContainer: self.countriesContainer)
        controller.tabBarItem = UITabBarItem(title: "Current", image: UIImage(named: "location-outline"), selectedImage: UIImage(named: "location-filled"))
        return controller
    }()
        
    public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        currentCountryDetector = CurrentCountryDetector()
        countriesContainer = CountriesContainer()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        viewControllers = [listViewController, currentCountryController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
