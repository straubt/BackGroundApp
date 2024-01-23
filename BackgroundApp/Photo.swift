//
//  Photo.swift
//  BackgroundApp
//
//  Created by Titouan STRAUB on 1/23/24.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let id, slug: String
    let urls: Urls
    let user: User
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: - User
struct User: Codable {
    let name: String
}
