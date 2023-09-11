//
//  SettingsModel.swift
//  Spoti
//
//  Created by Anıl Bürcü on 11.09.2023.
//

import Foundation

struct Section {
    let title:String
    let options:[Option]
}
struct Option {
    let title: String
    let handler: () -> Void
}
