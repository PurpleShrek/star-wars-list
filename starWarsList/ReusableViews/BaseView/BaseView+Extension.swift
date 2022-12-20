//
//  BaseView+Extension.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit

extension BaseView {
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
            activity.centerYAnchor.constraint(equalTo: centerYAnchor),
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        return activity
    }
    
    func makeRequestButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle("Internet request failed, press for repeat it", for: .normal)
        button.isHidden = true
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 80),
            button.widthAnchor.constraint(equalToConstant: bounds.width - 32),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        return button
    }
    
    func makeTextField() -> UITextField? {
        guard textFieldHeight != nil else { return nil }
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: textFieldHeight!)
        ])
        return textField
    }
    
    func makeTableView() -> UITableView {
        var topSpacing: CGFloat {
            guard textFieldHeight != nil else { return 0 }
            return textFieldHeight!
        }
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.decelerationRate = .fast
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: topSpacing),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        return tableView
    }
}
