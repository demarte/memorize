//
//  GameTheme.swift
//  Memorize
//
//  Created by Ivan on 01/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Theme {
  let themeName: ThemeName
  let numberOfPairsOfCards: Int?
  
  var emojis: [String] {
    let emojis = self.emojis(for: themeName)
    let numberOfPairsOfCards = self.numberOfPairsOfCards ?? Int.random(in: minimumNumberOfPairsOfCards..<emojis.count)
    let sliceArray = emojis.prefix(numberOfPairsOfCards)
    return Array<String>(sliceArray)
  }
  
  var themeColor: Color {
    switch themeName {
    case .haloween:
      return Color.orange
    case .animals:
      return Color.green
    case .faces:
      return Color.yellow
    case .flags:
      return Color.gray
    case .sports:
      return Color.blue
    case .fastFood:
      return Color.red
    }
  }
  
  init(themeName: ThemeName, numberOfPairsOfCards: Int? = nil) {
    self.themeName = themeName
    self.numberOfPairsOfCards = numberOfPairsOfCards
  }
  
  private func emojis(for theme: ThemeName) -> [String] {
    switch theme {
    case .haloween:
      return ["👻","🕷","🎃","🕸","🦇","🧛🏻‍♂️","🧟‍♂️"]
    case .sports:
      return ["🏀","🏋🏻‍♀️","🤺","🏓","🥊","🏄🏻‍♂️","🎾","⛳️","🥅"]
    case .faces:
      return ["🤓","🤪","😍","😝","🥵","🥶","🤬","🤯","😎","🤩","🤮"]
    case .flags:
      return ["🇧🇪", "🇧🇷", "🇦🇹","🇪🇬","🇮🇹","🇯🇵","🇳🇱","🇺🇸","🇺🇾","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🏴󠁧󠁢󠁷󠁬󠁳󠁿","🇵🇹","🇨🇦","🇺🇳"]
    case .animals:
      return ["🦧","🦑","🦞","🐢","🦒","🐬","🐠","🦖","🐈","🐿","🦃"]
    case .fastFood:
      return ["🍦","🍝","🍕","🍗","🍮","🍫","🍿","🍩","🍪","🥪","🧀","🥨"]
    }
  }
  
  enum ThemeName: String, CaseIterable {
    case haloween = "Haloween"
    case sports = "Sports"
    case faces = "Faces"
    case flags = "Flags"
    case animals = "Animals"
    case fastFood = "Fast Food"
  }
  
  // MARK: - Constants -
  
  let minimumNumberOfPairsOfCards = 5
}


