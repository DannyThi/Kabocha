//
//  RecipeViewModel.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/15.
//

import Foundation
import SwiftUI

final class RecipeViewModel: ObservableObject {
   
   @Published var meal: Meal
   @Published var image: UIImage?
   
   private var db = MealDatabase.shared

   init(meal: Meal) {
      self.meal = meal
      self.getImage()
   }
   
   func getImage() {
      db.fetchImage(urlString: meal.imageUrlString)
         .receive(on: DispatchQueue.main)
         .map { UIImage(data: $0) }
         .replaceError(with: nil)
         .assign(to: &$image)
   }
   
}
