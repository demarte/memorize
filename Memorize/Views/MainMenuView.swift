//
//  MainMenuView.swift
//  Memorize
//
//  Created by Ivan on 05/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct MainMenuView: View {
  
  var themes: Array<Theme>
  
  init() {
    self.themes = []
    let themeNames = Theme.Name.allCases
    for name in themeNames {
      self.themes.append(Theme(themeName: name))
    }
  }
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        List(themes) { theme in
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
      Text(theme.name.rawValue)
        .font(Font.title)
        .foregroundColor(theme.color)
      HStack {
        ForEach(0..<self.theme.emojis.count) { index in
          Text(self.theme.emojis[index])
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
