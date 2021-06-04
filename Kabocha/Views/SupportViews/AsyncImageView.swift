//
//  AsyncImageView.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/14.
//

import SwiftUI

struct AsyncImageView: View {
   
   @StateObject private var imageLoader: ImageLoader
   
   init(urlString: String?) {
      self._imageLoader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
   }
   
   var body: some View {
      image
         .onAppear {
            self.imageLoader.load()
         }
   }
   
   var image: some View {
      Group {
         if let image = imageLoader.image {
            Image(uiImage: image)
               .resizable()
               .scaledToFit()
               .clipped()
         } else {
            ProgressView()
         }
      }
   }
}

final class ImageLoader: ObservableObject {
   @Published var image: UIImage?
   var urlString: String?
   
   private var db = MealDatabase.shared
   
   init(urlString: String?) {
      self.urlString = urlString
   }
   
   func load() {
      guard let urlString = urlString else { return }
      db.fetchImage(urlString: urlString)
         .receive(on: DispatchQueue.main)
         .map { UIImage(data: $0) }
         .replaceError(with: nil)
         .assign(to: &$image)
   }
}
