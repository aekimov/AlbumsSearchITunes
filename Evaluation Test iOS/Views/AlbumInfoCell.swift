//
//  AlbumInfoCell.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit

class AlbumInfoCell: UITableViewCell { //Cell for TableView
    
    var albumInfo: AlbumInfo.Results? { //Setting values of properties
        didSet {
            self.trackNameLabel.text = albumInfo?.trackName
            self.artistNameLabel.text = albumInfo?.artistName
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [trackNameLabel, artistNameLabel]) //Creating StackView for two labels
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16)) //Anchoring stackViewin cell with padding
    }
    
    //Configuring labels
    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Intense"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Armin van Buuren"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
