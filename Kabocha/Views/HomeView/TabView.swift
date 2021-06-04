//
//  TabView.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/25.
//

import SwiftUI

struct HomeTabView: View {
   
   var body: some View {
      TabView {
         HomeView()
            .tabItem {
               Image(systemName: "house")
               Text("Home")
            }
         SearchView()
            .tabItem {
               Image(systemName: "magnifyingglass")
               Text("Search")
            }
         
      }
   }
}

struct HomeTabView_Previews: PreviewProvider {
   static var previews: some View {
      HomeTabView()
   }
}
