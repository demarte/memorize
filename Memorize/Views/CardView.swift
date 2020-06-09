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

  @State private var animatedBonusRemaining: Double = 0

  var body: some View {
    GeometryReader { geometry in
      self.body(for: geometry.size)
    }
  }

  private func startBonusTimeAnimation() {
    animatedBonusRemaining = card.bonusRemaining
    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
      animatedBonusRemaining = 0
    }
  }

  @ViewBuilder
  private func body(for size: CGSize) -> some View {
    if card.isFaceUp || !card.isMatched {
      ZStack {
        Group {
          if card.isConsumingBonusTime {
            Pie(
              startAngle: Angle.degrees(defaultPositionAngle - rotationAngle),
              endAngle: Angle.degrees(-animatedBonusRemaining * rotatedPositionAngle - rotationAngle),
              clockwise: true
            )
            .onAppear {
              self.startBonusTimeAnimation()
            }
          } else {
            Pie(
              startAngle: Angle.degrees(defaultPositionAngle - rotationAngle),
              endAngle: Angle.degrees(-card.bonusRemaining * rotatedPositionAngle - rotationAngle),
              clockwise: true
            )
          }
        }
        .padding(piePadding).opacity(pieOpacity)
        .transition(.scale)
        Text(card.content)
          .font(Font.system(size: fontSize(for: size)))
          .rotationEffect(Angle.degrees(card.isMatched ? rotatedPositionAngle : defaultPositionAngle))
          .animation(
            card.isMatched ?
              Animation.linear(duration: 1)
                .repeatForever(autoreverses: false) : .default
        )
      }
      .cardify(isFaceUp: card.isFaceUp)
      .transition(AnyTransition.scale)
    }
  }

  // MARK: - Drawing Constants -

  let pieOpacity: Double = 0.4
  let piePadding = EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
  let rotationAngle: Double = 90
  let defaultPositionAngle: Double = 0
  let rotatedPositionAngle: Double = 360

  private func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * 0.7
  }
}


struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    
    let game = EmojiMemoryGame(theme: Theme(themeName: .sports, numberOfPairsOfCards: 5))
    return CardView(card: game.cards[0])
  }
}
