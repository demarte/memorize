//
//  EmojiMemoryGame.swift
//  Momorize
//
//  Created by Ivan on 23/05/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
  
  private let theme: Theme
  // MARK: - Model -
  @Published private var memoryGame: MemoryGame<String>
  
  init(theme: Theme) {
    self.theme = theme
    self.memoryGame = MemoryGame<String>(cardsContent: theme.emojisToChoose)
  }
  
  // MARK: - Access to the Model -
  
  var cards: Array<MemoryGame<String>.Card> {
    memoryGame.cards
  }
  
  var color: Color {
    Color(theme.color)
  }
  
  var themeName: String {
    theme.name
  }
  
  var score: Int {
    memoryGame.score
  }
  
  func choose(card: MemoryGame<String>.Card) {
    memoryGame.choose(card: card)
  }

  func newGame() {
    memoryGame = MemoryGame<String>(cardsContent: theme.emojisToChoose)
  }
}
