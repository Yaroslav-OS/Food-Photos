//
//  FoodModel.swift
//  UnSplash Photos
//
//  Created by Yaroslav on 17.11.2020.
//

import Foundation

struct Food: Decodable {
    let id: String
    let urls: [String: String]
    let likes: Int
    let description: String?
    let alt_description: String?
}
