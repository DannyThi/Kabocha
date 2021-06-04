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
   @Published var isSearching: Bool = false
   
   private var db = MealDatabase.shared
   private var cancellables = Set<AnyCancellable>()
   
   func search(mealString: String) {
      isSearching = true
      db.fetchMealsBy(name: mealString)
         .receive(on: DispatchQueue.main)
         .sink { completion in
            switch completion {
            case let .failure(error):
               print(error.localizedDescription)
            case .finished:
               break
            }
            self.isSearching = false
         } receiveValue: { mealData in
            self.fetchedResults = mealData.meals
            self.isSearching = false
         }
         .store(in: &cancellables)
   }
   
}
