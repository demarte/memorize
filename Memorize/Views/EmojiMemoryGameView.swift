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
      .onAppear {
        self.game.printJson()
    }
  }
  
  private func body(for game: EmojiMemoryGame) -> some View {
    VStack {
      Grid(game.cards) { card in
        CardView(card: card).onTapGesture {
          withAnimation(.linear(duration: self.flipCardDuration)) {
            game.choose(card: card)
          }
        }
        .padding(self.cardPadding)
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
        withAnimation(.easeInOut) {
          game.newGame()
        }
      }
    )
  }
  
  // MARK: - Constants -
  
  private let flipCardDuration: Double = 0.75
  private let cardPadding = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiMemoryGameView(game: EmojiMemoryGame(
      theme: Theme(
        themeName: "Fast Food",
        emojis: ["🍦","🍝","🍕","🍗","🍮","🍫","🍿","🍩","🍪","🥪","🧀","🥨"],
        color: UIColor.RGB(red: 0.5, green: 0.5, blue: 0.5, alpha: 1),
        numberOfPairsOfCards: 5)
      )
    )
  }
}
