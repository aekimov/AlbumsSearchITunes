//
//  HeaderTableView.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit
import WebKit

class AlbumInfoViewForHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let labelsStackView = UIStackView(arrangedSubviews: [collectionNameLabel, artistNameLabel, genreLabel, releaseDateLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        labelsStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))

        let stackView = UIStackView(arrangedSubviews: [artworkImageView, labelsStackView])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        contentView.backgroundColor = .white
    }

    let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    
    let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Intense"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Armin van Buuren"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .purple
        label.numberOfLines = 1
        return label
    }()


    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Trance"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

