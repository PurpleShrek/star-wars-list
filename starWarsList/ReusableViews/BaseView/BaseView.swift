//
//  BaseView.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit
import Combine

final class BaseView: UIView {
    //MARK: - Views
    lazy var activityIndicator = makeActivityIndicator()
    lazy var requestButton = makeRequestButton()
    lazy var textField = makeTextField()
    lazy var tableView = makeTableView()
    
    //MARK: - Init
    let textFieldHeight: CGFloat?
    
    required init(textFieldHeight: CGFloat?) {
        self.textFieldHeight = textFieldHeight
        super.init(frame: .zero)
        self.backgroundColor = .darkGray
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Funcs
    @MainActor
    public func stopActivityIndicator() {
        textField?.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    @MainActor
    public func showRepeatButton() {
        requestButton.isHidden = false
    }
    
    @MainActor
    public func hideButtonShowActivity() {
        requestButton.isHidden = true
        activityIndicator.startAnimating()
    }
}
