//
//  AlbumManager.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit


final class AlbumManager {
    
    func getAlbum(_ searchText: String, completionHandler: @escaping (Result <AlbumInfoModel, APIService.APIError>) -> Void) {
        
        //Search by the name of album
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&media=music&entity=album&attribute=albumTerm"
        let url = urlString.encodeUrl //Encode url into utf8
        
        APIService.shared.getJSON(urlString: url) { (result: Result <AlbumInfoModel, APIService.APIError>) in
            completionHandler(result)
        }
    }
    
    func getAlbumInfoAndSongs(_ collectionId: Int, completionHandler: @escaping (Result <AlbumInfoModel, APIService.APIError>) -> Void) {
        
        //Search by collectionId (album Id) in order to show songs and info
        let url = "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song"
        APIService.shared.getJSON(urlString: url) { (result: Result <AlbumInfoModel, APIService.APIError>) in
            completionHandler(result)
        }
    }
}
