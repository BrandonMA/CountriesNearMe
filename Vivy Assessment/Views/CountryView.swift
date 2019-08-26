//
//  CountryView.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/24/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import SwifterUI
import MapKit

class CountryView: SFScrollView {
    
    lazy var contentStack: SFStackView = {
        let stack = SFStackView(arrangedSubviews: [flagImageView, mapView, nameLabel, populationLabel, areaLabel, capitalLabel, regionLabel, languageLabel, currencyLabel, regionalBlocksLabel, latitudeLabel, longitudeLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var flagImageViewHeightConstraint: Constraint?
    lazy var flagImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.kf.indicatorType = .activity
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var nameLabel: SFLabel = {
        let view = SFLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var populationLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        return view
    }()
    
    lazy var areaLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        return view
    }()
    
    lazy var capitalLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        return view
    }()
    
    lazy var regionLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        return view
    }()
    
    lazy var regionalBlocksLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var languageLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var currencyLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var latitudeLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var longitudeLabel: SFLabel = {
        let view = SFLabel(useAlternativeColors: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: UIFont.systemFontSize - 2)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()

    public override init(automaticallyAdjustsColorStyle: Bool = true, useAlternativeColors: Bool = false, frame: CGRect = .zero) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle, useAlternativeColors: useAlternativeColors, frame: frame)
        scrollsHorizontally = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareSubviews() {
        contentView.addSubview(contentStack)
        super.prepareSubviews()
    }
    
    override func setConstraints() {
        contentStack.clipSides(exclude: [.bottom], margin: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12))
        flagImageViewHeightConstraint = flagImageView.setHeight(SFDimension(value: 100))
        contentView.clipBottom(to: .bottom, of: contentStack, margin: -12)
        mapView.setHeight(SFDimension(value: 200))
        super.setConstraints()
    }
    
    override func layoutSubviews() {
        let newHeight = (3 * (frame.size.width - 24)) / 5 // Substract the margin from both sides, then calculate the 3/5 aspect ratio
        if (flagImageViewHeightConstraint == nil) {
            flagImageViewHeightConstraint = flagImageView.setHeight(SFDimension(value: newHeight))
        } else if (flagImageViewHeightConstraint?.constant != newHeight) {
            flagImageViewHeightConstraint?.constant = newHeight
        }
        super.layoutSubviews()
    }
}
