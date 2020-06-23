//
//  Theme.swift
//  Memorize
//
//  Created by Ivan on 01/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Theme: Identifiable {
  let id: String
  let name: Name
  var numberOfPairsOfCards: Int?
  
  var emojis: [String] {
    let emojis = self.emojis(for: name)
    if let numberOfPairs = self.numberOfPairsOfCards {
      let sliceArray = emojis.prefix(numberOfPairs)
      return Array<String>(sliceArray)
    }
    return emojis
  }
  
  var color: Color {
    switch name {
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
  
  init(themeName: Name, numberOfPairsOfCards: Int? = nil) {
    self.id = UUID().uuidString
    self.name = themeName
    setUpNumberOfPairsOfCards()
  }
  
  private mutating func setUpNumberOfPairsOfCards() {
    if numberOfPairsOfCards == nil {
      let emojis = self.emojis(for: name)
      let randomNumberOfCards = Int.random(in: minimumNumberOfPairsOfCards..<emojis.count)
      self.numberOfPairsOfCards = randomNumberOfCards
    }
  }
  
  private func emojis(for theme: Name) -> [String] {
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
  
  enum Name: String, CaseIterable {
    case haloween = "Haloween"
    case sports = "Sports"
    case faces = "Faces"
    case flags = "Flags"
    case animals = "Animals"
    case fastFood = "Fast Food"
  }
  
  // MARK: - Constants -
  
  private let minimumNumberOfPairsOfCards = 5
}


