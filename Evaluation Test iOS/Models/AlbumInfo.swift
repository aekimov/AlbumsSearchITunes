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
        let releaseDate: String
    }
    let results: [Results]
}


//"resultCount": 13,
//"results": [
//{
//"wrapperType": "collection",
//"collectionType": "Album",
//"artistId": 17976294,
//"collectionId": 1579676313,
//"amgArtistId": 335537,
//"artistName": "Armin van Buuren",
//"collectionName": "A State of Trance FOREVER",
//"collectionCensoredName": "A State of Trance FOREVER",
//"artistViewUrl": "https://music.apple.com/us/artist/armin-van-buuren/17976294?uo=4",
//"collectionViewUrl": "https://music.apple.com/us/album/a-state-of-trance-forever/1579676313?uo=4",
//"artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/21/1e/ef/211eef1a-656e-4f37-595a-c3bd26da7bd6/source/60x60bb.jpg",
//"artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/21/1e/ef/211eef1a-656e-4f37-595a-c3bd26da7bd6/source/100x100bb.jpg",
//"collectionPrice": 8.99,
//"collectionExplicitness": "notExplicit",
//"trackCount": 12,
//"copyright": "℗ 2021 Armada Music B.V. under exclusive license from Armin Audio B.V.",
//"country": "USA",
//"currency": "USD",
//"releaseDate": "2021-09-03T07:00:00Z",
//"primaryGenreName": "Trance"
//},
//{
//"wrapperType": "track",
//"kind": "song",
//"artistId": 17976294,
//"collectionId": 1579676313,
//"trackId": 1579676314,
//"artistName": "Armin van Buuren",
//"collectionName": "A State of Trance FOREVER",
//"trackName": "Turn the World into a Dancefloor (Asot 1000 Anthem)",
//"collectionCensoredName": "A State of Trance FOREVER",
//"trackCensoredName": "Turn the World into a Dancefloor (Asot 1000 Anthem)",
//"artistViewUrl": "https://music.apple.com/us/artist/armin-van-buuren/17976294?uo=4",
//"collectionViewUrl": "https://music.apple.com/us/album/turn-the-world-into-a-dancefloor-asot-1000-anthem/1579676313?i=1579676314&uo=4",
//"trackViewUrl": "https://music.apple.com/us/album/turn-the-world-into-a-dancefloor-asot-1000-anthem/1579676313?i=1579676314&uo=4",
//"previewUrl": "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/d3/e3/07/d3e30724-ac77-4aed-909f-b2be3ac19d8b/mzaf_9392784897550276152.plus.aac.p.m4a",
//"artworkUrl30": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/21/1e/ef/211eef1a-656e-4f37-595a-c3bd26da7bd6/source/30x30bb.jpg",
//"artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/21/1e/ef/211eef1a-656e-4f37-595a-c3bd26da7bd6/source/60x60bb.jpg",
//"artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Music115/v4/21/1e/ef/211eef1a-656e-4f37-595a-c3bd26da7bd6/source/100x100bb.jpg",
//"collectionPrice": 8.99,
//"trackPrice": 1.29,
//"releaseDate": "2021-01-21T12:00:00Z",
//"collectionExplicitness": "notExplicit",
//"trackExplicitness": "notExplicit",
//"discCount": 1,
//"discNumber": 1,
//"trackCount": 12,
//"trackNumber": 1,
//"trackTimeMillis": 214001,
//"country": "USA",
//"currency": "USD",
//"primaryGenreName": "Trance",
//"isStreamable": true
//},
