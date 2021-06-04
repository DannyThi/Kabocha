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
            ScrollView {
               ForEach(viewModel.fetchedResults, id: \.self) { meal in
                  Text(meal.name)
               }
            }
         }
         .navigationTitle("List")
      }
   }
   
   @ViewBuilder
   private func mealCell() -> some View {
      
   }
}

struct SearchView_Previews: PreviewProvider {
   static var previews: some View {
      SearchView()
   }
}
