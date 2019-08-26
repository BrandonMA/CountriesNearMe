//
//  ListViewCell.swift
//  Vivy Assetment
//
//  Created by brandon maldonado alonso on 7/24/19.
//  Copyright © 2019 brandon maldonado alonso. All rights reserved.
//

import UIKit
import SwifterUI

class ListViewCell: SFTableViewCell {
    
    override class var height: CGFloat {
        return 87
    }
    
    override class var identifier: String {
        return "ListViewCell"
    }
    
    lazy var flagImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.kf.indicatorType = .activity
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var contentStack: SFStackView = {
        let stack = SFStackView(arrangedSubviews: [nameLabel, populationLabel, areaLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    override func prepareSubviews() {
        contentView.addSubview(flagImageView)
        contentView.addSubview(contentStack)
        super.prepareSubviews()
    }
    
    override func setConstraints() {
        flagImageView.clipTop(to: .top, margin: 12)
        flagImageView.clipBottom(to: .bottom, margin: 12)
        flagImageView.clipLeft(to: .left, margin: 12)
        flagImageView.setWidth(SFDimension(value: 105))
        
        contentStack.clipLeft(to: .right, of: flagImageView, margin: 12)
        contentStack.clipSides(exclude: [.left], margin: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 12))
        super.setConstraints()
    }
    
}
