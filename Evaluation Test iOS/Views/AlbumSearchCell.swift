//
//  AlbumSearchCell.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 24.09.2021.
//

import UIKit
import SDWebImage

class AlbumSearchCell: UICollectionViewCell {
    
    var album: Album.Results? {
        didSet {
            self.collectionNameLabel.text = album?.collectionName
            self.artistNameLabel.text = album?.artistName

            guard let url = URL(string: album?.artworkUrl100 ?? "" ) else { return }
            artworkImageView.sd_setImage(with: url)
  
        }
    }
    
    let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let collectionNameLabel: UILabel = {
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
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let stackView = UIStackView(arrangedSubviews: [artworkImageView, collectionNameLabel, artistNameLabel])
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
