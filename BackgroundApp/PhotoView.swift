//
//  PhotoView.swift
//  BackgroundApp
//
//  Created by Titouan STRAUB on 1/24/24.
//

import SwiftUI

struct PhotoView: View {
    let photo: Photo
    @State private var url: Urls.CodingKeys = Urls.CodingKeys.raw
    var body: some View {
        VStack{
            Picker("size", selection: $url){
                ForEach(Urls.CodingKeys.allCases, id: \.self) { url in
                    Text(url.rawValue)
                }
            }.pickerStyle(.palette)
            AsyncImage(url: URL(string: url.getValue(urls: photo.urls))) { image in
                image.centerCropped()
            } placeholder: {
                ProgressView()
            }.scaledToFit()
                .frame(height: url.getSize(urls: photo.urls))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }.navigationTitle("Photo by " + photo.user.name)
    }
}

//#Preview {
//    PhotoView()
//}
