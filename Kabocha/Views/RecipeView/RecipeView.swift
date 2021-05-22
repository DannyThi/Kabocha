//
//  RecipeView.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/14.
//

import SwiftUI

struct RecipeView: View {
   
   @StateObject private var viewModel: RecipeViewModel
   
   init(meal: Meal) {
      self._viewModel = StateObject(wrappedValue: RecipeViewModel(meal: meal))
   }
   
   var body: some View {
      ScrollView {
         VStack {
            mealImage
            Divider()
            mealIngredients
            Divider()
            mealInstructions
         }
         .padding()
         .navigationBarTitle(viewModel.meal.name, displayMode: .inline)
      }
   }
   
   var mealImage: some View {
      Group {
         if let image = viewModel.image {
            Image(uiImage: image)
               .resizable()
               .frame(maxWidth: .infinity)
               .scaledToFit()
               .cornerRadius(8)
               .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
               .padding()
         } else {
            ProgressView()
         }
      }
   }
   
   var mealIngredients: some View {
      Group {
         if let ingredients = viewModel.meal.ingredients {
            HStack {
               Text("Ingredients")
                  .font(.title2)
                  .fontWeight(.semibold)
                  .padding(.bottom, 2)
               Spacer()
            }
            ForEach(ingredients, id: \.self) { ingredient in
               HStack {
                  Text(ingredient.name)
                  Spacer()
                  Text(ingredient.measure)
               }
            }
         }
      }
   }
   
   var mealInstructions: some View {
      Group {
         if let instructions = viewModel.meal.instructions {
            HStack {
               Text("Instructions")
                  .font(.title2)
                  .fontWeight(.semibold)
                  .padding(.bottom, 2)
               Spacer()
            }
            Text(instructions)
         }
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      RecipeView(meal: Meal.example)
   }
}
