//
//  SearchViewModel.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/24.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
   
   @Published private var fetchedResults: [Meal] = []
   @Published var filtered: [Meal] = []
   @Published var isFetching = false
      
   var searchBarController = SearchBarController()

   private var db = MealDatabase.shared
   private var cancellables = Set<AnyCancellable>()
   
   init() {

   }
   
   func search(mealString: String) {
      
   }
   
}
