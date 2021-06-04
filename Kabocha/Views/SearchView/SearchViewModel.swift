//
//  SearchViewModel.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/24.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
   
   @Published var fetchedResults: [Meal] = []

   private var db = MealDatabase.shared
   private var cancellables = Set<AnyCancellable>()
   
   func search(mealString: String) {
      db.fetchMealsBy(name: mealString)
         .receive(on: DispatchQueue.main)
         .sink { completion in
            switch completion {
            case let .failure(error):
               print(error.localizedDescription)
            case .finished:
               break
            }
         } receiveValue: { mealData in
            self.fetchedResults = mealData.meals
         }
         .store(in: &cancellables)
   }
   
}
