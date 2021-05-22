//
//  AsyncImageView.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/14.
//

import SwiftUI

struct AsyncImageView: View {
   
   @StateObject private var imageLoader = ImageLoader()
   @Binding var urlString: String?
   
   init(urlString: Binding<String?>) {
      self._urlString = urlString
   }
   
   var body: some View {
      image
         .onChange(of: urlString) { url in
            if let urlString = url {
               imageLoader.urlString = urlString
               imageLoader.load()
            }
         }
   }
   
   var image: some View {
      Group {
         if let image = imageLoader.image {
            Image(uiImage: image)
               .resizable()
               .scaledToFit()
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

   func load() {
      print("Loading")
      guard let urlString = urlString else { return }
      db.fetchImage(urlString: urlString)
         .receive(on: DispatchQueue.main)
         .map { UIImage(data: $0) }
         .replaceError(with: nil)
         .assign(to: &$image)
   }
}
