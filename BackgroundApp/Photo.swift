//
//  Photo.swift
//  BackgroundApp
//
//  Created by Titouan STRAUB on 1/23/24.
//

import Foundation

// MARK: - Welcome
struct Photo: Codable, Identifiable {
    let id, slug: String
    let urls: Urls
    let user: User
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb: String
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
        
        func getValue(urls: Urls) -> String{
            switch self{
            case .raw:
                urls.raw
            case .full:
                urls.full
            case .regular:
                urls.regular
            case .small:
                urls.small
            case .thumb:
                urls.thumb
            }
        }
        
        func getSize(urls: Urls) -> CGFloat{
            switch self{
            case .raw:
                400
            case .full:
                300
            case .regular:
                200
            case .small:
                100
            case .thumb:
                50
            }
        }
    }
}

// MARK: - User
struct User: Codable {
    let name: String
}
