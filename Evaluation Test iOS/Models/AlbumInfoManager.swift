//
//  AlbumInfoManager.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import Foundation

protocol AlbumsInfoManagerDelegate {
    func didUpdateAlbums(albumInfo: AlbumInfo)
    func didFailWithError(error: String)
}

class AlbumInfoManager {
    
    var delegate: AlbumsInfoManagerDelegate?
    
    func getAlbumInfoAndSongs(collectionId: Int) {
        
        //Search by collectionId (album Id) in order to show songs and info
        let url = "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song"
        
        APIService.shared.getJSON(urlString: url) { (result: Result <AlbumInfo, APIService.APIError>) in
            switch result {
            case .success(let albumInfo):
                self.delegate?.didUpdateAlbums(albumInfo: albumInfo)
        
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    print(errorString)
                    self.delegate?.didFailWithError(error: errorString)
                    
                }
            }
        }
    }
    
}
