//
//  WorldView.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import UIKit

final class WorldView: UIView {
    //MARK: - Views
    lazy var activityIndicator = makeActivityIndicator()
    
    lazy var labelsStackView = makeLabelsStackView()
    
    lazy var nameLabel = makeTextLabel()
    lazy var diameterLabel = makeTextLabel()
    lazy var climateLabel = makeTextLabel()
    lazy var gravityLabel = makeTextLabel()
    lazy var terrainLabel = makeTextLabel()
    lazy var populationLabel = makeTextLabel()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public funcs
    public func setLabels(world: World?) {
        labelsStackView.alpha = 1
        activityIndicator.startAnimating()
        nameLabel.text = "Name: \(world?.name ?? "")"
        diameterLabel.text = "Diameter: \(world?.diameter ?? "")"
        climateLabel.text = "Climate: \(world?.climate ?? "")"
        gravityLabel.text = "Gravity: \(world?.gravity ?? "")"
        terrainLabel.text = "Terrain: \(world?.terrain ?? "")"
        populationLabel.text = "Population: \(world?.population ?? "")"
    }
    
    //MARK: - Public Funcs
    @MainActor
    public func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

