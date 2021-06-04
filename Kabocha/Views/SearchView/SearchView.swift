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
               // search
            }
            .padding()
            
         }
         .navigationTitle("List")
      }
   }
}

struct SearchView_Previews: PreviewProvider {
   static var previews: some View {
      SearchView()
   }
}
