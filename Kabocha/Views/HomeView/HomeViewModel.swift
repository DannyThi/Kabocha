//
//  HomeViewModel.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/15.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
   
   @Published var randomMeal: Meal?
   @Published var randomMealImageURL: String?
   
   private let db = MealDatabase.shared
   private var cancellables = Set<AnyCancellable>()
   
   init() {
      fetchMeal()
   }
   
   func fetchMeal() {
      db.fetchRandomMeal()
         .receive(on: DispatchQueue.main)
         .sink { completion in
            switch completion {
            case let .failure(error):
               print("Failed to retrieve meal: \(error.localizedDescription)")
            case .finished:
               print("Fetch Meal: Finished")
            }
         } receiveValue: { mealData in
            if let meal = mealData.meals.first {
               self.randomMeal = meal
               self.randomMealImageURL = meal.imageUrlString
            }
         }
         .store(in: &cancellables)
   }
}
