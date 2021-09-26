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




//"resultCount": 200,
//"results": [
//{
//        "wrapperType": "collection",
//        "collectionType": "Album",
//        "artistId": 17976294,
//        "collectionId": 430648994,
//        "amgArtistId": 335537,
//        "artistName": "Armin van Buuren, Paul Oakenfold & Cosmic Gate",
//        "collectionName": "A State of Trance 500 (Mixed by Armin van Buuren, Paul Oakenfold, Cosmic Gate And More)",
//        "collectionCensoredName": "A State of Trance 500 (Mixed by Armin van Buuren, Paul Oakenfold, Cosmic Gate And More)",
//        "artistViewUrl": "https://music.apple.com/us/artist/armin-van-buuren/17976294?uo=4",
//        "collectionViewUrl": "https://music.apple.com/us/album/a-state-of-trance-500-mixed-by-armin-van-buuren/430648994?uo=4",
//        "artworkUrl60": "https://is3-ssl.mzstatic.com/image/thumb/Music/v4/70/1f/d3/701fd35c-9912-01d8-fc17-e385dafed89c/source/60x60bb.jpg",
//        "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Music/v4/70/1f/d3/701fd35c-9912-01d8-fc17-e385dafed89c/source/100x100bb.jpg",
//        "collectionPrice": -1,
//        "collectionExplicitness": "notExplicit",
//        "trackCount": 74,
//        "copyright": "℗ 2011 Armada Music B.V.",
//        "country": "USA",
//        "currency": "USD",
//        "releaseDate": "2011-04-15T07:00:00Z",
//        "primaryGenreName": "Dance"
//},
