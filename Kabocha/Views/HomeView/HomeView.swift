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
               randomMealCard
               HStack {
                  searchByNameCard
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
   
   var randomMealCard: some View {
      NavigationLink(destination: recipeView()) {
         VStack {
            VStack {
               HStack {
                  Text(viewModel.randomMeal?.name ?? "")
                     .font(.title)
                     .fontWeight(.bold)
                     .lineLimit(1)
                     .accentColor(.black)
                  Spacer()
               }
                  .padding([.top,.horizontal])
               
               AsyncImageView(urlString: $viewModel.randomMealImageURL)
                  .cornerRadius(8)
            }
               .cardView()
         }
            .padding()
      }
   }
   
   var searchByNameCard: some View {
      NavigationLink(destination: Text("Search by name")) {
         VStack {
            HStack {
               Text("Search meals by name")
                  .font(.headline)
                  .fontWeight(.semibold)
                  .accentColor(.black)
               Spacer()
               Image(systemName: "chevron.right")
            }
            Divider()
         }
         .cardView()
      }
      .padding()
   }
   
   @ViewBuilder
   private func recipeView() -> some View {
      if let meal = viewModel.randomMeal {
         RecipeView(meal: meal)
      } else {
         Text("No recipe available")
      }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
