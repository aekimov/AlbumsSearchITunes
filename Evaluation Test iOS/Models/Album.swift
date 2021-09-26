//
//  Album.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 24.09.2021.
//

import Foundation

struct Album: Codable {
    let resultCount: Int
    struct Results: Codable {
        let collectionId: Int
        let artistName: String
        let collectionName: String
        let artworkUrl100: String
    }
    let results: [Results]
}
