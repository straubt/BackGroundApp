//
//  FeedState.swift
//  BackgroundApp
//
//  Created by Titouan STRAUB on 1/24/24.
//

import Foundation
import SwiftUI

enum Route: String{
    case PHOTOS = "/photos"
    case TOPICS = "/topics"
    case TOPICS_PHOTOS = ""
    
    func buildRoute(id: String?) -> String{
        switch self{
            
        case .PHOTOS:
            self.rawValue
        case .TOPICS:
            self.rawValue
        case .TOPICS_PHOTOS:
            if let myId = id{
                Route.TOPICS.rawValue + "/\(myId)" + Route.PHOTOS.rawValue
            }
            else{
                fatalError()
            }
        }
    }
}

class FeedState: ObservableObject{
    @Published var imageList: [Photo]? = []
    @Published var topicList: [Topic]? = []
    @Published var topicImages: [Photo]? = []
    
    init(){
    }
    
    func getPhotos(orderBy: String = "popular", perPage: Int = 10, path: Route = .PHOTOS, id: String? = nil) async {
        let url = PhotoAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path.buildRoute(id: id))
        if let requestUrl = url {
            do {
                // Créez une requête avec cette URL
                let request = URLRequest(url: requestUrl)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([Photo].self, from: data)
                
                // Mettez à jour l'état de la vue
                await MainActor.run{
                    if(path == .PHOTOS){
                        imageList = deserializedData
                    } else{
                        topicImages = deserializedData
                    }
                }
                
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func getTopics(orderBy: String = "popular", perPage: Int = 10, path: Route = .TOPICS) async {
        let url = PhotoAPI.feedUrl(orderBy: orderBy, perPage: perPage, path: path.rawValue)
        if let requestUrl = url {
            do {
                // Créez une requête avec cette URL
                let request = URLRequest(url: requestUrl)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([Topic].self, from: data)
                
                // Mettez à jour l'état de la vue
                await MainActor.run{
                    topicList = deserializedData
                }
                
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
