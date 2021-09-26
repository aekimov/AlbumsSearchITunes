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

        let url = "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song" //Поиск по названию альбома из поисковой строки
        print(url)
        
        APIService.shared.getJSON(urlString: url) { (result: Result <AlbumInfo, APIService.APIError>) in
            switch result {
            case .success(let albumInfo): // финальный объект тот что мы получаем
                print(albumInfo.resultCount)
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
