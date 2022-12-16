//
//  MainView+Extension.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit

extension MainView {
    //MARK: - Layout
    func makeActivityIndicator() -> UIActivityIndicatorView {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        activity.layer.zPosition = 1
        activity.color = .blue
        activity.startAnimating()
        return activity
    }
    
    func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .blue
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        return textField
    }
    
    func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.decelerationRate = .fast
        tableView.separatorStyle = .none
        return tableView
    }
    
    //MARK: - AddSubview
    func addSubviews() {
        let subviews = [activityIndicator, textField, tableView]
        
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    //MARK: - Constraints
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
