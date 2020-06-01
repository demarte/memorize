//
//  EmojiMemoryGameView.swift
//  Momorize
//
//  Created by Ivan on 23/05/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  
  @ObservedObject var game: EmojiMemoryGame
  
  var body: some View {
    body(for: self.game)
  }
  
  private func body(for game: EmojiMemoryGame) -> some View {
    VStack {
      Text(game.themeName)
      Grid(game.cards) { card in
        CardView(card: card, color: game.color).onTapGesture {
          game.choose(card: card)
        }
        .padding(5)
      }
      Button("New Game") {
        print("New Game")
        let gameTheme = GameTheme(themeName: .animals, numberOfPairsOfCards: 5)
        game.newGame(gameTheme: gameTheme)
      }
      .padding()
      .border(game.color, width: borderButtonWidth)
    }
    .foregroundColor(game.color)
    .padding()
  }
  
  // MARK: - Constants -
  
  let borderButtonWidth: CGFloat = 2.0
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiMemoryGameView(game: EmojiMemoryGame(gameTheme: GameTheme(themeName: .fastFood, numberOfPairsOfCards: 5)))
  }
}
