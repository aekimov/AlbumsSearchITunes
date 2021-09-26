//
//  AlbumInfo.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import Foundation

struct AlbumInfo: Codable {
    let resultCount: Int
    struct Results: Codable {
        let collectionId: Int
        let artistName: String
        let collectionName: String
        let artworkUrl100: String
        let trackName: String?
        let primaryGenreName: String
        let releaseDate: String?
    }
    let results: [Results]
}
