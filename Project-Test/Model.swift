//
//  Model.swift
//  Project-Test
//
//  Created by MNC Insurance 1 on 18/10/23.
//

import Foundation


struct Photos : Codable {
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}

struct Posts : Codable {
    let title: String?
    let body: String?
}



enum APIType {
    case photos
    case posts

    var endpoint: String {
        switch self {
        case .photos:
            return "https://jsonplaceholder.typicode.com/photos"
        case .posts:
            return "https://jsonplaceholder.typicode.com/posts"
        }
    }
}


