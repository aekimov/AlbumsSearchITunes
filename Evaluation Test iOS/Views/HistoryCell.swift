//
//  HistoryCell.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 26.09.2021.
//

import UIKit

class HistoryCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))

    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Intense"
//        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
