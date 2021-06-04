//
//  HomeView.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/14.
//

import SwiftUI

struct HomeView: View {
   @ObservedObject private var viewModel: HomeViewModel
   
   init(viewModel: HomeViewModel = HomeViewModel()) {
      self.viewModel = viewModel
   }
   
   var body: some View {
      NavigationView {
         ScrollView {
            VStack {
               ForEach(viewModel.mealArray, id: \.self) { meal in
                  mealCard(for: meal)
               }
            }
         }
         .navigationBarTitle("Home",displayMode: .inline)
         .toolbar {
            toolBar
         }
      }
   }
   
   var toolBar: some ToolbarContent {
      Group {
         ToolbarItem(placement: .navigationBarTrailing) {
            Button("Next Meal") {
               viewModel.fetchMeal()
            }
         }
      }
   }
   

   @ViewBuilder
   private func mealCard(for meal: Meal) -> some View {
      NavigationLink(destination: RecipeView(meal: meal)) {
         VStack {
            HStack {
               Text(meal.name)
                  .font(.title)
                  .fontWeight(.bold)
                  .lineLimit(1)
                  .accentColor(.black)
               Spacer()
            }
            .padding([.top,.horizontal])
            
            AsyncImageView(urlString: meal.imageUrlString)
               .cornerRadius(8)
         }
         .cardView()
         .padding()
      }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
