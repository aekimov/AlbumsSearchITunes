//
//  HeaderTableView.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit

final class AlbumInfoViewForHeader: UITableViewHeaderFooterView { //View for Header of TableView

    var headerInfo: AlbumInfoModel? {
        didSet {
            collectionNameLabel.text = headerInfo?.results[0].collectionName
            artistNameLabel.text = headerInfo?.results[0].artistName
            genreLabel.text = headerInfo?.results[0].primaryGenreName
            releaseDateLabel.text? = date.transformDate(date: headerInfo?.results[0].releaseDate ?? "")
            guard let url = URL(string: headerInfo?.results[0].artworkUrl100 ?? "" ) else { return }
            artworkImageView.sd_setImage(with: url)
        }
    }
   
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //Creating two StackViews, one for stackView of labels, and one more for stackView and image
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

    //Configuring image and Labels
    let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Album"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()

    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .purple
        label.numberOfLines = 1
        return label
    }()

    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Genre"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Year"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    let date: String = ""
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
