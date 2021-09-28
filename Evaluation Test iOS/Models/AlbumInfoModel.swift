//
//  AlbumInfo.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import Foundation

struct AlbumInfoModel: Codable {
    let resultCount: Int
    let results: [Results]
}
struct Results: Codable {
    let collectionId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackName: String?
    let primaryGenreName: String?
    let releaseDate: String?
}
