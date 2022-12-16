//
//  MainTableViewCell+Extension.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 16/12/2022.
//

import UIKit

extension MainTableViewCell {
    //MARK: - ContentViewPreferences
    func contentViewPreferences() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.cornerCurve = .continuous
//        contentView.clipsToBounds = true
//        contentView.backgroundColor = .cell
    }
    
    //MARK: - Layout
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }
    
    func makeBaseLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }
    
    func makeDateLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .systemRed
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 20)
        return label
    }
    
    //MARK: - AddSubview
    func addSubviews() {
        let subviews = [myTitleLabel, directorLabel, producerLabel, dateLabel]
        
        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK: - Constraints
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            myTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            myTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            myTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            myTitleLabel.heightAnchor.constraint(equalToConstant: 35),
            
            directorLabel.topAnchor.constraint(equalTo: myTitleLabel.bottomAnchor, constant: 6),
            directorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            directorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            directorLabel.heightAnchor.constraint(equalToConstant: 25),
            
            producerLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 6),
            producerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            producerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            producerLabel.heightAnchor.constraint(equalToConstant: 25),
            
            dateLabel.topAnchor.constraint(equalTo: producerLabel.bottomAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            dateLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
