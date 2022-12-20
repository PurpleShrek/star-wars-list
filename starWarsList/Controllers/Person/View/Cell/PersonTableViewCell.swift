//
//  PersonTableViewCell.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import UIKit
import Combine

final class PersonTableViewCell: BaseCell {
    //MARK: - Identifier
    public static let identifier = "personTableViewCell"
    
    //MARK: - Data
    public var person: Person? {
        didSet {
            setUpConstraints()
            setUpViewModel()
        }
    }
    
    //MARK: - Constraints
    @MainActor
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: myTitleLabel.bottomAnchor, constant: 5),
            dateLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 5)
        ])
    }
    
    //MARK: - Set data
    @MainActor
    private func setUpViewModel() {
        myTitleLabel.text = "Name: \(person?.name ?? "")"
        secondLabel.text = "Gender: \(person?.gender ?? "")"
        dateLabel.text = "Release date: \(person?.birthYear ?? "")"
    }
}
