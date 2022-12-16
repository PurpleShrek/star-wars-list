//
//  MainView.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit

final class MainView: UIView {
    //MARK: - Views
    lazy var activityIndicator = makeActivityIndicator()
    lazy var textField = makeTextField()
    lazy var tableView = makeTableView()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Funcs
    public func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
