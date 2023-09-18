//
//  RecommendationsResponse.swift
//  Spoti
//
//  Created by Anıl Bürcü on 12.09.2023.
//

import Foundation

struct RecommendationsResponse: Codable {
    
    let tracks: [AudioTrack]
}
