//
//  SearchView.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/24.
//

import SwiftUI

struct SearchView: View {
   
   @StateObject private var viewModel = SearchViewModel()
   @State private var searchString: String = ""
   
   var body: some View {
      NavigationView {
         VStack {
            TextField("Search for a Meal", text: $searchString) { _ in } onCommit: {
               self.viewModel.search(mealString: searchString)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            ScrollView(.vertical, showsIndicators: false) {
               if viewModel.isSearching {
                  ProgressView()
               } else {
                  ForEach(viewModel.fetchedResults, id: \.self) { meal in
                     cell(for: meal)
                  }
               }
            }
            .padding()
         }
         .navigationTitle("List")
      }
   }
   
   @ViewBuilder
   private func cell(for meal: Meal) -> some View {
      NavigationLink(destination: RecipeView(meal: meal)) {
         VStack {
            HStack {
               Text(meal.name.capitalized)
                  .accentColor(.primary)
               Spacer()
               AsyncImageView(urlString: meal.imageUrlString)
                  .frame(width: 44, height: 44)
               Image(systemName: "chevron.right")
            }
            Divider()
         }
      }
   }
}

struct SearchView_Previews: PreviewProvider {
   static var previews: some View {
      SearchView()
   }
}
