//
//  AlbumManager.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit


protocol AlbumsManagerDelegate {
    func didUpdateAlbums(album: Album)
    func didFailWithError(error: String)
}

class AlbumManager {
    
    var delegate: AlbumsManagerDelegate?
    
    func getAlbum(searchText: String?) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText ?? "")&media=music&entity=album&attribute=albumTerm&limit=50"
        let url = urlString.encodeUrl //Поиск по названию альбома из поисковой строки
        
        print(url)
        
        APIService.shared.getJSON(urlString: url) { (result: Result <Album, APIService.APIError>) in
            switch result {
            case .success(let album): // финальный объект тот что мы получаем
//                let sortedAlbum = album.results.sorted { (first, second) -> Bool in
//                    first.collectionName < first.collectionName
//                }
//                print(album.results)
//                print(sortedAlbum)
                self.delegate?.didUpdateAlbums(album: album)
        
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    
                    self.delegate?.didFailWithError(error: errorString)
                    
                }
            }
        }
    }
    
}
