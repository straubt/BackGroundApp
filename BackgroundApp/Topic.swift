//
//  Topic.swift
//  BackgroundApp
//
//  Created by Titouan STRAUB on 1/24/24.
//

import Foundation

struct Topic: Codable, Identifiable{
    let id: String
    let slug: String
    let title: String
    let description: String
    let total_photos: Int
    let status: String
    let links: Links //links to go to the web page
    let cover_photo: Photo
}

struct Links: Codable{
    let it: String
    let html: String
    let photos: String
    
    enum CodingKeys: String, CodingKey {
        case it = "self"
        case html
        case photos
    }
}
