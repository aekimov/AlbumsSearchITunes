//
//  SongsViewController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit

//VC for showing info and songs

class AlbumInfoViewController: UITableViewController, AlbumsInfoManagerDelegate {

    fileprivate let cellId = "cellId"
    fileprivate let albumInfoManager = AlbumInfoManager()
    fileprivate let albumViewForHeader = AlbumInfoViewForHeader() //View for tableView header
    var array = [String]()
    
    var collectionId: Int?
    var albumInfo: AlbumInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(AlbumInfoCell.self, forCellReuseIdentifier: cellId)
        albumInfoManager.delegate = self
        guard let collectionId = collectionId else { return }
        albumInfoManager.getAlbumInfoAndSongs(collectionId: collectionId) // request to show info and songs

        tableView.contentInset = UIEdgeInsets(top: 90, left: 0, bottom: 0, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    fileprivate let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.color = .darkGray
    return indicator
    }()
    
    
    //MARK: - Protocol Methods
    
    func didUpdateAlbums(albumInfo: AlbumInfo) {
        DispatchQueue.main.async {
            self.albumInfo = albumInfo
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "URL not found.", message: error, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.activityIndicatorView.removeFromSuperview()
            }))
            self.present(alertController, animated: true)
        }
    }
    //MARK: - TableView DataSource and Delegate Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let albumInfo = albumInfo else { return 0 }
        return albumInfo.results.count - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AlbumInfoCell
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

    //MARK: - DateFormatter func
    
    fileprivate func transformDate(date: String) -> String {
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
}
    


