//
//  MemoryGame.swift
//  Momorize
//
//  Created by Ivan on 23/05/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  
  var cards: Array<Card> = []
  
  var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get { cards.indices.filter { cards[$0].isFaceUp }.only }
    set {
      for index in cards.indices {
        cards[index].isFaceUp = index == newValue
      }
    }
  }
  
  struct Card: Identifiable {
    let id: String
    var isFaceUp = false
    var isMatch = false
    let content: CardContent
  }
  
  init(cardsContent: [CardContent]) {
    newGame(cardsContent: cardsContent)
  }
  
  
  /// Choose a `card`
  /// - Parameter card: a MemoryGame Card
  /// - Author: Ivan De Martino
  mutating func choose(card: Card) {
    if let chosenIndex = cards.firstIndex(matching: card),
      !cards[chosenIndex].isFaceUp,
      !cards[chosenIndex].isMatch {
      
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatch = true
          cards[potentialMatchIndex].isMatch = true
        }
        self.cards[chosenIndex].isFaceUp = true
      } else {
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
    }
  }

  mutating func newGame(cardsContent: [CardContent]) {
    cards = Array<Card>()
    for content in cardsContent {
      cards.append(Card(id: UUID().uuidString ,content: content))
      cards.append(Card(id: UUID().uuidString ,content: content))
    }
    cards.shuffle()
  }
}
