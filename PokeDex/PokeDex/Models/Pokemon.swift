//
//  Pokemon.swift
//  PokeDex
//
//  Created by 김도윤 on 2023/01/18.
//

import Foundation

struct Pokemon: Codable {
    var id: Int?
    var name: String?
    var imageUrl: String?
    var backImageUrl: String?
    var weight: Int?
    var height: Int?
    var baseExperience: Int?
    var type: String?
}
