//
//  MenuItem.swift
//  Restaurant
//
//  Created by Samson Lopez on 04/05/2023.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let image: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case image = "image"
        case price = "price"
    }
}
