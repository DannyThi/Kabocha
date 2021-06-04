//
//  SearchBar.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/24.
//

import SwiftUI
import Combine

class SearchBarController: NSObject, ObservableObject, UISearchResultsUpdating {
   let searchController = UISearchController(searchResultsController: nil)
   
   var text = CurrentValueSubject<String,Never>("")
   
   override init() {
      super.init()
      self.searchController.obscuresBackgroundDuringPresentation = false
      self.searchController.searchResultsUpdater = self
   }
   
   func updateSearchResults(for searchController: UISearchController) {
      if let searchText = searchController.searchBar.text {
         self.text.value = searchText
      }
   }
   
   
}

struct SearchControllerProviderModifier: ViewModifier {
   let searchControllerProvider: SearchBarController
   
   func body(content: Content) -> some View {
      content
         .overlay(
            ViewControllerResolver { viewController in
                viewController.navigationItem.searchController = self.searchControllerProvider.searchController
            }
                .frame(width: 0, height: 0)
         )
   }
}

extension View {
   func searchBar(from searchControllerProvider: SearchBarController) -> some View {
      return self.modifier(SearchControllerProviderModifier(searchControllerProvider: searchControllerProvider))
   }
}

final class ViewControllerResolver: UIViewControllerRepresentable {
   let onResolve: (UIViewController) -> Void
   
   func makeUIViewController(context: Context) -> some ParentResolverViewController {
      ParentResolverViewController(onResolve: onResolve)
   }
   
   func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
   
   init(onResolve: @escaping (UIViewController) -> Void) {
      self.onResolve = onResolve
   }
}

// We use this class to help us provide access to the parent view controller.
class ParentResolverViewController: UIViewController {
   let onResolve: (UIViewController) -> Void
   
   init(onResolve: @escaping (UIViewController) -> Void) {
      self.onResolve = onResolve
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func didMove(toParent parent: UIViewController?) {
      super.didMove(toParent: parent)
      
      if let parent = parent {
         onResolve(parent)
      }
   }
}
