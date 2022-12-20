//
//  MainTableViewCell.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import UIKit

final class MainTableViewCell: BaseCell {
    //MARK: - Identifier
    public static let identifier = "mainTableViewCell"
    
    public var film: Film? {
        didSet {
            setUpConstraints()
            setUpViewModel()
        }
    }

    @MainActor
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: myTitleLabel.bottomAnchor, constant: 2),
            thirdLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 4),
            dateLabel.topAnchor.constraint(equalTo: thirdLabel.bottomAnchor, constant: 4)
        ])
    }
    
    @MainActor
    private func setUpViewModel() {
        myTitleLabel.text = "Name: \(film?.title ?? "")"
        secondLabel.text = "Director: \(film?.director ?? "")"
        thirdLabel.text = "Producers: \(film?.producer ?? "")"
        dateLabel.text = "Release date: \(film?.releaseDate ?? "")"
    }
}
