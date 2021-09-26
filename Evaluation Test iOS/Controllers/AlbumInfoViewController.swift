//
//  SongsViewController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit

class AlbumInfoViewController: UITableViewController, AlbumsInfoManagerDelegate {

    fileprivate let cellId = "cellId"
    fileprivate let albumInfoManager = AlbumInfoManager()
    fileprivate let albumViewForHeader = AlbumInfoViewForHeader()
    var array = [String]()

    var collectionId: Int?
    var albumInfo: AlbumInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(AlbumInfoCell.self, forCellReuseIdentifier: cellId)
//        tableView.contentInsetAdjustmentBehavior = .never
        albumInfoManager.delegate = self
        guard let collectionId = collectionId else { return }
        albumInfoManager.getAlbumInfoAndSongs(collectionId: collectionId)
    }
    
    func didUpdateAlbums(albumInfo: AlbumInfo) {
        DispatchQueue.main.async {
            self.albumInfo = albumInfo
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: String) {
        print(error)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let albumInfo = albumInfo else { return 0 }
        return albumInfo.results.count - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AlbumInfoCell
        let info = albumInfo?.results[indexPath.row + 1] // Начинается с 1 элемента, так как 0 элемент это описание альбома
        cell.albumInfo = info
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerUIView = AlbumInfoViewForHeader()
        headerUIView.collectionNameLabel.text = albumInfo?.results[0].collectionName
        headerUIView.artistNameLabel.text = albumInfo?.results[0].artistName
        headerUIView.genreLabel.text = albumInfo?.results[0].primaryGenreName
        headerUIView.releaseDateLabel.text = albumInfo?.results[0].releaseDate

        guard let url = URL(string: albumInfo?.results[0].artworkUrl100 ?? "" ) else { return nil }
        headerUIView.artworkImageView.sd_setImage(with: url)
        
        return headerUIView
        
//
//        let label = UILabel()
//        label.text = albumInfo?.results[0].primaryGenreName
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//        label.textColor = .purple
//        return label
    }
    
}
    

    
    


