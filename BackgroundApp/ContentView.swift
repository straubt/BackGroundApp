//
//  ContentView.swift
//  BackgroundApp
//
//  Created by Titouan STRAUB on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let rows = [GridItem(.flexible())]
    @StateObject var feedState: FeedState = FeedState()
    var body: some View {
            NavigationStack {
                // le bouton va lancer l'appel réseau
                Button(action: {
                    Task {
                        await feedState.getPhotos()
                        await feedState.getTopics()
                    }
                }, label: {
                    Text("Load Data")
                })
                ScrollView(.horizontal){
                    if let topicList = feedState.topicList{
                        LazyHGrid(rows: rows){
                            ForEach(topicList) { topic in
                                VStack{
                                    AsyncImage(url: URL(string: topic.cover_photo.urls.raw)) { image in
                                        image.centerCropped()
                                    } placeholder: {
                                        ProgressView()
                                    }.frame(width: 200, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    NavigationLink{
                                        TopicView(topic: topic)
                                            .onAppear(perform: {
                                                feedState.topicImages = []
                                            })
                                    } label: {
                                        Text(topic.title)
                                    }
                                }
                            }
                        }
                    }
                }.clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 10)
                ScrollView {
                    if let imageList = feedState.imageList {
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
                .navigationTitle("Feed")
            }
            .environmentObject(feedState)
        }
}

#Preview {
    ContentView()
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
