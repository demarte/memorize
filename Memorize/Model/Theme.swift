//
//  Theme.swift
//  Memorize
//
//  Created by Ivan on 01/06/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import SwiftUI

struct Theme: Identifiable, Codable {
  
  let id: String
  let name: String
  let emojis: [String]
  let color: UIColor.RGB
  let numberOfPairsOfCards: Int
  
  init(themeName: String, emojis: [String], color: UIColor.RGB, numberOfPairsOfCards: Int) {
    self.id = UUID().uuidString
    self.name = themeName
    self.emojis = emojis
    self.color = color
    self.numberOfPairsOfCards = numberOfPairsOfCards
  }
  
  var emojisToChoose: [String] {
    Array(emojis.prefix(numberOfPairsOfCards))
  }
  
  var json: Data? {
    return try? JSONEncoder().encode(self)
  }
  
  static let mockData = [
    Theme(
      themeName: "Faces",
      emojis: ["🤓","🤪","😍","😝","🥵","🥶","🤬","🤯","😎","🤩","🤮"],
      color: UIColor.RGB(red: 0.9, green: 0.74, blue: 0.23, alpha: 1),
      numberOfPairsOfCards: 7),
    Theme(
      themeName: "Halloween",
      emojis: ["👻","🕷","🎃","🕸","🦇","🧛🏻‍♂️","🧟‍♂️", "🦉"],
      color: UIColor.RGB(red: 0.87, green: 0.46, blue: 0, alpha: 1),
      numberOfPairsOfCards: 8),
    Theme(
      themeName: "Sports",
      emojis: ["🏀","🏋🏻‍♀️","🤺","🏓","🥊","🏄🏻‍♂️","🎾","⛳️","🥅"],
      color: UIColor.RGB(red: 0.45, green: 0.73, blue: 0.98, alpha: 1),
      numberOfPairsOfCards: 9),
    Theme(
      themeName: "Flags",
      emojis: ["🇧🇪", "🇧🇷", "🇦🇹","🇪🇬","🇮🇹","🇯🇵","🇳🇱","🇺🇸","🇺🇾","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🏴󠁧󠁢󠁷󠁬󠁳󠁿","🇵🇹","🇨🇦","🇺🇳"],
      color: UIColor.RGB(red: 0.5, green: 0.54, blue: 0.53, alpha: 1),
      numberOfPairsOfCards: 10),
    Theme(
      themeName: "Animals",
      emojis: ["🦧","🦑","🦞","🐢","🦒","🐬","🐠","🦖","🐈","🐿","🦃"],
      color: UIColor.RGB(red: 0.59, green: 0.78, blue: 0.64, alpha: 1),
      numberOfPairsOfCards: 11),
    Theme(
      themeName: "Fast Food",
      emojis: ["🍦","🍝","🍕","🍗","🍮","🍫","🍿","🍩","🍪","🥪","🧀","🥨"],
      color: UIColor.RGB(red: 0.93, green: 0.17, blue: 0.17, alpha: 1),
      numberOfPairsOfCards: 12),
  ]
  
  // MARK: - Constants -
  
  private let minimumNumberOfPairsOfCards = 5
}


