//
//  Artist.swift
//  Spoti
//
//  Created by Anıl Bürcü on 11.09.2023.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
