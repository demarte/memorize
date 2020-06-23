//
//  MainMenuView.swift
//  Memorize
//
//  Created by Ivan on 05/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct MainMenuView: View {
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        List(Theme.mockData) { theme in
          NavigationLink(destination: EmojiMemoryGameView(game: EmojiMemoryGame(theme: theme))) {
            ThemeRow(theme: theme)
          }
        }
      }
      .navigationBarTitle("Themes")
    }
  }
}

struct ThemeRow: View {
  
  var theme: Theme
  
  var body: some View {
    VStack(alignment: .leading){
      Text(theme.name)
        .font(Font.title)
        .foregroundColor(Color(theme.color))
      HStack {
        ForEach(theme.emojisToChoose, id: \.self) { emoji in
          Text(emoji)
        }
      }
    }
  }
}

struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    MainMenuView()
  }
}
