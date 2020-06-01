//
//  CardView.swift
//  Momorize
//
//  Created by Ivan on 23/05/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct CardView: View {
  
  var card: MemoryGame<String>.Card
  var color: Color
  
  var body: some View {
    GeometryReader { geometry in
      self.body(for: geometry.size)
    }
  }
  
  private func body(for size: CGSize) -> some View {
    ZStack {
      if card.isFaceUp {
        RoundedRectangle(cornerRadius: 10).fill(Color.white)
        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
        Text(card.content)
      } else {
        if !card.isMatch {
          RoundedRectangle(cornerRadius: 10).fill(color)
        }
      }
    }
//    .aspectRatio(2/3, contentMode: .fit)
    .font(Font.system(size: fontSize(for: size)))
  }
  
  // MARK: - Drawing Constants -
  let cornerRadius: CGFloat = 10.0
  let edgeLineWidth: CGFloat = 3
  
  private func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * 0.75
  }
}


struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    
    let game = EmojiMemoryGame(gameTheme: GameTheme(themeName: .sports, numberOfPairsOfCards: 5))
    return CardView(card: game.cards[0], color: game.color)
  }
}
