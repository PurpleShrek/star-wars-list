//
//  BaseCell.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import UIKit

class BaseCell: UITableViewCell {
    //MARK: - Views
    lazy var myTitleLabel = makeTitleLabel()
    lazy var secondLabel = makeBaseLabel()
    lazy var thirdLabel = makeBaseLabel()
    lazy var dateLabel = makeDateLabel()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentViewPreferences()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Overriden funcs
    override func layoutSubviews() {
        super.layoutSubviews()
        let margins = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
}
