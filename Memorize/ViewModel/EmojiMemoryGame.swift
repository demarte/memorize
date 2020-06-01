//
//  EmojiMemoryGame.swift
//  Momorize
//
//  Created by Ivan on 23/05/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  
  var gameTheme: GameTheme
  // MARK: - Model -
  @Published private var memoryGame: MemoryGame<String>
  
  init(gameTheme: GameTheme) {
    self.gameTheme = gameTheme
    self.memoryGame = MemoryGame<String>(cardsContent: gameTheme.emojis)
  }
  
  // MARK: - Access to the Model -
  
  var cards: Array<MemoryGame<String>.Card> {
    memoryGame.cards
  }
  
  var color: Color {
    gameTheme.themeColor
  }
  
  var themeName: String {
    gameTheme.themeName.rawValue
  }
  
  func choose(card: MemoryGame<String>.Card) {
    memoryGame.choose(card: card)
  }
}
