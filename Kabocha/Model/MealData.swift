//
//  MealData.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/14.
//

import Foundation

struct MealData: Decodable {
   let meals: [Meal]
}

struct Meal: Decodable, Hashable {
   let name: String
   let imageUrlString: String
   let ingredients: [Ingredient]
   let instructions: String
   var imageData: Data? = nil
   
   init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      let mealDict = try container.decode([String: String?].self)
      
      var index = 1
      var ingredients = [Ingredient]()
      
      while let ingredient = mealDict["strIngredient\(index)"] as? String,
            let measure = mealDict["strMeasure\(index)"] as? String,
            !ingredient.isEmpty,
            !measure.isEmpty {
         
         ingredients.append(.init(name: ingredient, measure: measure))
         index += 1
      }
      
      self.init(name: mealDict["strMeal"] as? String ?? "",
                imageUrl: mealDict["strMealThumb"] as? String ?? "",
                ingredients: ingredients,
                instructions: mealDict["strInstructions"] as? String ?? "")
   }
   
   private init(name: String, imageUrl: String, ingredients: [Ingredient], instructions: String) {
      self.name = name
      self.imageUrlString = imageUrl
      self.ingredients = ingredients
      self.instructions = instructions
   }
   
   static var example = Meal(name: "Test Cake",
                             imageUrl: "\(Bundle.main.path(forResource: "girl-cooking", ofType: ".png")!)",
                             ingredients: [Ingredient(name: "Flour", measure: "220g"),
                                           Ingredient(name: "Eggs", measure: "2"),
                                          Ingredient(name: "Magic cake dust", measure: "10g")],
                             instructions: "These are some instructions to make a cake. \n1) Add ingredients. \n2) Mix. \n3) ???. \n4) Profit.")
}

struct Ingredient: Decodable, Hashable {
   let name: String
   let measure: String
}


