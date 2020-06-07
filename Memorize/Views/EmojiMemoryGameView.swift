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
      Grid(game.cards) { card in
        CardView(card: card, color: game.color).onTapGesture {
          game.choose(card: card)
        }
        .padding(5)
      }
      Text("Score: \(game.score)")
        .font(Font.title)
        .padding()
      
    }
    .foregroundColor(game.color)
    .padding()
    .navigationBarTitle(game.themeName)
    .navigationBarItems(trailing:
      Button("New Game") {
        game.newGame()
      }
    )
  }
  
  // MARK: - Constants -
  
  private let borderButtonWidth: CGFloat = 2.0
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiMemoryGameView(game: EmojiMemoryGame(theme: Theme(themeName: .fastFood, numberOfPairsOfCards: 5)))
  }
}
