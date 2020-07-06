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
  var name: String
  var emojis: [String]
  var color: UIColor.RGB
  var numberOfPairsOfCards: Int
  
  init(themeName: String, emojis: [String], color: UIColor.RGB, numberOfPairsOfCards: Int) {
    self.id = UUID().uuidString
    self.name = themeName
    self.emojis = emojis
    self.color = color
    self.numberOfPairsOfCards = numberOfPairsOfCards
  }
  
  init?(json: Data?) {
    if json != nil, let newTheme = try? JSONDecoder().decode(Theme.self, from: json!) {
      self = newTheme
    } else {
      return nil
    }
  }
  
  var emojisToChoose: [String] {
    Array(emojis.prefix(numberOfPairsOfCards))
  }
  
  var json: Data? {
    return try? JSONEncoder().encode(self)
  }
}


