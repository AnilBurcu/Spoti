//
//  SearchResult.swift
//  Spoti
//
//  Created by Anıl Bürcü on 21.09.2023.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
