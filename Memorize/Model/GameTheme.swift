//
//  GameTheme.swift
//  Memorize
//
//  Created by Ivan on 01/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct GameTheme {
  let themeName: ThemeName
  let numberOfPairsOfCards: Int?
  
  var emojis: [String] {
    let emojis = self.emojis(for: themeName)
    let sliceArray = emojis.prefix(numberOfPairsOfCards ?? randomNumberOfCards())
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
  
  private func randomNumberOfCards() -> Int {
    Int.random(in: minimumNumberOfPairsOfCards...emojis.count)
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
  
  enum ThemeName: String {
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


