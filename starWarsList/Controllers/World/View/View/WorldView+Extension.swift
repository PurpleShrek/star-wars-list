//
//  WorldView+Extension.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import UIKit

extension WorldView {
    //MARK: - Layout
    func makeActivityIndicator() -> UIActivityIndicatorView {
        let activity = UIActivityIndicatorView()
        activity.backgroundColor = .clear
        activity.style = .large
        activity.layer.zPosition = 0
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activity)
        NSLayoutConstraint.activate([
            activity.bottomAnchor.constraint(equalTo: labelsStackView.topAnchor, constant: -20),
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        return activity
    }
    
    func makeTextLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 40),
            label.widthAnchor.constraint(equalToConstant: bounds.width - 64)
        ])
        return label
    }
    
    func makeLabelsStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.layer.cornerRadius = 10
        stackView.layer.cornerCurve = .continuous
        stackView.backgroundColor = .white
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(diameterLabel)
        stackView.addArrangedSubview(climateLabel)
        stackView.addArrangedSubview(gravityLabel)
        stackView.addArrangedSubview(terrainLabel)
        stackView.addArrangedSubview(populationLabel)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        return stackView
    }
}
