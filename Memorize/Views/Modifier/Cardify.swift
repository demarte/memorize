//
//  Cardify.swift
//  Memorize
//
//  Created by Ivan De Martino on 6/8/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {

  var rotation: Double

  var isFaceUp: Bool {
    rotation < 90
  }

  init(isFaceUp: Bool) {
    rotation = isFaceUp ? 0 : 180
  }

  var animatableData: Double {
    get { rotation }
    set { rotation = newValue }
  }

  func body(content: Content) -> some View {
    ZStack {
      Group {
        RoundedRectangle(cornerRadius: 10).fill(Color.white)
        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
        content
      }
        .opacity(isFaceUp ? 1 : 0)
      RoundedRectangle(cornerRadius: 10).fill()
        .opacity(isFaceUp ? 0 : 1)
    }
    .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
  }

  // MARK: - Drawing Constants -
  private let cornerRadius: CGFloat = 10.0
  private let edgeLineWidth: CGFloat = 3

}

extension View {
  func cardify(isFaceUp: Bool) -> some View {
    self.modifier(Cardify(isFaceUp: isFaceUp))
  }
}