//
//  PhotosAPI.swift
//  BackgroundApp
//
//  Created by Titouan STRAUB on 1/24/24.
//

import Foundation

struct PhotoAPI{
    
    static func unsplashApiBaseUrl() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId)
        ]
        return components
    }
    
    static func feedUrl(orderBy: String = "popular", perPage: Int = 10, path: String = "/photos") -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = path
        let queryItems = [
            URLQueryItem(name: "order_by", value: orderBy),
            URLQueryItem(name: "per_page", value: String(perPage))
        ]
        components.queryItems?.append(contentsOf: queryItems)
        return components.url
    }
}
