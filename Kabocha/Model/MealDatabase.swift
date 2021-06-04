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
   private init() { }

   private func fetch(urlString: String) ->AnyPublisher<URLSession.DataTaskPublisher.Output,URLError> {
      guard let url = URL(string: urlString) else {
         return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
      }
      
      return URLSession.shared
         .dataTaskPublisher(for: url)
         .eraseToAnyPublisher()
   }
   
   func fetchRandomMeal() -> AnyPublisher<MealData,Error> {
      
      let url = "\(baseURL)random.php"
      
      return fetch(urlString: url)
         .map { $0.data }
         .decode(type: MealData.self, decoder: JSONDecoder())
         .eraseToAnyPublisher()
   }
   
   func fetchMealsBy(letter: String) -> AnyPublisher<MealData,Error> {
      let trimmed = trimCharacters(of: letter)
      let urlString = baseURL + "search.php?f=" + trimmed
      
      return fetch(urlString: urlString)
         .map { $0.data }
         .decode(type: MealData.self, decoder: JSONDecoder())
         .eraseToAnyPublisher()
   }
   
   
   func fetchMealsBy(name: String) -> AnyPublisher<MealData,Error> {
      let trimmedName = trimCharacters(of: name)
      let urlString = baseURL + "search.php?s=" + trimmedName

      return fetch(urlString: urlString)
         .map { $0.data }
         .decode(type: MealData.self, decoder: JSONDecoder())
         .eraseToAnyPublisher()
   }
   
   
   // IMAGE
   func fetchImage(urlString: String) ->AnyPublisher<Data,URLError> {
      if let image = imageCache.object(forKey: NSString(string: urlString)) as Data? {
         return Just(image).setFailureType(to: URLError.self).eraseToAnyPublisher()
      }
      
      guard let url = URL(string: urlString) else {
         return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
      }
      return URLSession.shared
         .dataTaskPublisher(for: url)
         .map { output -> Data in
            let data = output.data
            self.imageCache.setObject(NSData(data: data), forKey: NSString(string: urlString))
            return data
         }
         .eraseToAnyPublisher()
   }
   
   
   private func trimCharacters(of string: String) -> String {
      return string.trimmingCharacters(in: .urlQueryAllowed).trimmingCharacters(in: .whitespacesAndNewlines)
   }
}

enum KBCError: LocalizedError {
   case `default`(description: String? = nil)
}
