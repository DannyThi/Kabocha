//
//  CardViewModifier.swift
//  Kabocha
//
//  Created by Hai Long Danny Thi on 2021/05/22.
//

import SwiftUI

struct CardViewModifier: ViewModifier {

   func body(content: Content) -> some View {
      content
         .padding()
         .frame(maxWidth: .infinity)
         .background(Color.white)
         .cornerRadius(8)
         .shadow(color: .black.opacity(0.2), radius: 10, x: 5, y: 5)
   }
}

extension View {
   func cardView() -> some View {
      self
         .modifier(CardViewModifier())
   }
}
