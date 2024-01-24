//
//  TopicView.swift
//  BackgroundApp
//
//  Created by Titouan STRAUB on 1/24/24.
//

import SwiftUI

struct TopicView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var topic: Topic
    @EnvironmentObject var feedState: FeedState
    var body: some View {
        Button(action: {
            Task{
                await feedState.getPhotos(path: Route.TOPICS_PHOTOS, id: topic.id)
            }
        }, label: {
            Text("Load images")
        })
        ScrollView {
            if let imageList = feedState.topicImages {
                LazyVGrid(columns: columns) {
                    ForEach(imageList) { imageUrl in
                        AsyncImage(url: URL(string: imageUrl.urls.raw)) { image in
                            image.centerCropped()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            } else {
                LazyVGrid(columns: columns) {
                    ForEach(1...12, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 12)
                                        .foregroundColor(Color.gray.opacity(0.3))
                                        .frame(height: 150)
                    }
                }
                .redacted(reason: .placeholder)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 10)
        .navigationTitle(topic.title)
    }
}

//#Preview {
//    TopicView(topic: Topic(), feedState: FeedState())
//}
