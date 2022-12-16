//
//  MainTableViewCell.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 16/12/2022.
//

import UIKit
import Combine

final class MainTableViewCell: UITableViewCell {
    //MARK: - Identifier
    public static let identifier = "filmTableViewCell"
    
    //MARK: - ViewModel
    public var viewModel: MainCellViewModel! {
        didSet { setUpViewModel() }
    }
    
    //MARK: - Tap Cell
    var index: IndexPath?
    lazy var passthroughSubject = PassthroughSubject<IndexPath?, Never>()
    lazy var tapCell = passthroughSubject.eraseToAnyPublisher()
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))

    //MARK: - Views
    lazy var myTitleLabel = makeTitleLabel()
    lazy var directorLabel = makeBaseLabel()
    lazy var producerLabel = makeBaseLabel()
    lazy var dateLabel = makeDateLabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }

    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addGestureRecognizer(tap)
        contentViewPreferences()
        addSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func didTapScreen(touch: UITapGestureRecognizer) {
        passthroughSubject.send(index)
    }

    //MARK: - Set ViewModel
    private func setUpViewModel() {
        myTitleLabel.text = viewModel.filmData?.title
        directorLabel.text = viewModel.filmData?.director
        producerLabel.text = viewModel.filmData?.producer
        dateLabel.text = viewModel.filmData?.releaseDate
    }
}
