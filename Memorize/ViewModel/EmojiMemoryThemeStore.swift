//
//  EmojiMemoryGameStore.swift
//  Memorize
//
//  Created by Ivan on 04/07/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI
import Combine

final class EmojiMemoryThemeStore: ObservableObject {
  
  @Published var themes: [Theme] = []
  
  private var autosave: AnyCancellable?
  
  init() {
    
    if let data = UserDefaults.standard.array(forKey: EmojiMemoryThemeStore.userDefaultsKey) {
      
      self.themes = data.compactMap { element in
        Theme(json: element as? Data)
      }
    }
    
    autosave = $themes.sink(receiveValue: { themes in
      let data = themes.map { $0.json }
      UserDefaults.standard.set(data, forKey: EmojiMemoryThemeStore.userDefaultsKey)
    })
  }
  
  func newTheme() {
    let theme = Theme(themeName: EmojiMemoryThemeStore.untitled, emojis: ["🤓","🤪","😍","😝","🥵","🥶","🤬"], color: UIColor.RGB(red: 0.9, green: 0.74, blue: 0.23, alpha: 1), numberOfPairsOfCards: 7)
    themes.append(theme)
  }
  
  static private let untitled = "Untitled"
  static private let userDefaultsKey = "EmojiMemoryThemeStore"
}
