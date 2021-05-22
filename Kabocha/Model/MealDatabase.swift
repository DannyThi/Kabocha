//
//  MealDatabase.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/14.
//

import Foundation
import Combine

final class MealDatabase: ObservableObject {
   
   static let shared = MealDatabase()

   private var cancellables = Set<AnyCancellable>()
   private let baseURL: String = "https://www.themealdb.com/api/json/v1/1/"
   private var imageCache = NSCache<NSString,NSData>()
   private init() {
      // load cache from store
   }

   func fetchRandomMeal() -> AnyPublisher<MealData,Error> {
      
      let url = URL(string: baseURL + "random.php")!
      
      return URLSession.shared
         .dataTaskPublisher(for: url)
         .map { $0.data }
         .decode(type: MealData.self, decoder: JSONDecoder())
         .eraseToAnyPublisher()
   }
   
   func fetchImage(urlString: String) ->AnyPublisher<Data,URLError> {
      if let image = imageCache.object(forKey: NSString(string: urlString)) as Data? {
         return Just(image).setFailureType(to: URLError.self).eraseToAnyPublisher()
      }
      
      let url = URL(string: urlString)!
      return URLSession.shared
         .dataTaskPublisher(for: url)
         .map { output -> Data in
            let data = output.data
            self.imageCache.setObject(NSData(data: data), forKey: NSString(string: urlString))
            return data
         }
         .eraseToAnyPublisher()
   }
}

enum KBCError: LocalizedError {
   case `default`(description: String? = nil)
}
