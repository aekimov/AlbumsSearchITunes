//
//  SongsViewController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit

//VC for showing info and songs

final class AlbumInfoViewController: UITableViewController {

    private let cellId = "cellId"
    private let albumManager = AlbumManager()
    private let albumViewForHeader = AlbumInfoViewForHeader() //View for tableView header
    
    var collectionId: Int?
    private var albumInfo: AlbumInfoModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(AlbumInfoCell.self, forCellReuseIdentifier: cellId)
        guard let collectionId = collectionId else { return }
        fetchData(collectionId: collectionId) // request to show info and songs
    }
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.color = .darkGray
    return indicator
    }()

    //MARK: - DateFormatter func
    
    private func transformDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy"
            dateFormatter.locale = tempLocale
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return ""
    }


private func fetchData(collectionId: Int) {
    
    albumManager.getAlbumInfoAndSongs(collectionId) { result in
        switch result {
        case .success(let albumInfo):
            DispatchQueue.main.async {
                self.albumInfo = albumInfo
                self.tableView.reloadData()
            }
            
        case .failure(let apiError):
            switch apiError {
            case .error(let errorString):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Connection Error.", message: errorString, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        self.activityIndicatorView.removeFromSuperview()
                    }))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
}
}

//MARK: - TableView DataSource and Delegate Methods

extension AlbumInfoViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let albumInfo = albumInfo else { return 0 }
        return albumInfo.results.count - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AlbumInfoCell) else { return UITableViewCell() }
        cell.backgroundColor = .white
        let info = albumInfo?.results[indexPath.row + 1] //Start from first element because zero element is album description
        cell.albumInfo = info
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if albumInfo?.resultCount != nil {
            
            let headerUIView = AlbumInfoViewForHeader()
            headerUIView.collectionNameLabel.text = albumInfo?.results[0].collectionName
            headerUIView.artistNameLabel.text = albumInfo?.results[0].artistName
            headerUIView.genreLabel.text = albumInfo?.results[0].primaryGenreName
            headerUIView.releaseDateLabel.text = transformDate(date: (albumInfo?.results[0].releaseDate) ?? "")
            
            guard let url = URL(string: albumInfo?.results[0].artworkUrl100 ?? "" ) else { return nil }
            headerUIView.artworkImageView.sd_setImage(with: url)
            return headerUIView
        } else {
            self.view.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.centerInSuperview()
            return activityIndicatorView
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return albumInfo?.resultCount == 0 ? view.frame.height : 150
    }
}

