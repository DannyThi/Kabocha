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
                  .padding()            }
         }
         .frame(maxWidth: .infinity)
         .background(Color.white)
         .cornerRadius(8)
         .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
         .padding(16)
      }
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
