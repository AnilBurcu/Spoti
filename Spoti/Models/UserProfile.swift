//
//  UserProfile.swift
//  Spoti
//
//  Created by Anıl Bürcü on 11.09.2023.
//

import Foundation

struct UserProfile:Codable {
    let country:String
    let display_name:String
    let email:String
//    let explicit_content: [String:Bool]
//    let external_url: [String:String]
//    let followers: [String:Codable?]
    let id:String
    let product: String
    let images:[UserImage]
    
}
struct UserImage:Codable {
    let url: String
}
