//
//  LibraryAlbumsRespons.swift
//  Spoti
//
//  Created by Anıl Bürcü on 28.09.2023.
//

import Foundation

struct LibraryAlbumsResponse:Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum:Codable {
    let added_at: String
    let album:Album
}
