//
//  AlbumManager.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit


protocol AlbumsManagerDelegate { //protocol to transfer data and errors
    func didUpdateAlbums(albumResults: [Album.Results])
    func didFailWithError(error: String)
}

class AlbumManager {

    var delegate: AlbumsManagerDelegate?
    var sortedResults = [Album.Results]()
    
    func getAlbum(searchText: String?) {
        guard let searchTerm = searchText else { return }
        
        //Search by the name of album
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&media=music&entity=album&attribute=albumTerm&limit=20"
        let url = urlString.encodeUrl //Encode url into utf8
        
        //print(url)
        
        APIService.shared.getJSON(urlString: url) { (result: Result <Album, APIService.APIError>) in
            switch result {
            case .success(let album):
                
                self.sortedResults = album.results.sorted { $0.collectionName < $1.collectionName } //Sort in alphabetical order
                self.delegate?.didUpdateAlbums(albumResults: self.sortedResults) //Results - array of albums
                
            case .failure(let apiError):
                switch apiError {
                case .error(let errorString):
                    self.delegate?.didFailWithError(error: errorString) // Error
                    
                }
            }
        }
    }
    
}
