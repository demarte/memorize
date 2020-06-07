//
//  MemoryGame.swift
//  Momorize
//
//  Created by Ivan on 23/05/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  
  struct Card: Identifiable {
    let id: String
    var isFaceUp = false
    var isMatch = false
    let content: CardContent
  }
  
  private(set) var cards: Array<Card> = []
  private(set) var score = 0
  private var seenCardsIndicies: Set<Int> = []
  
  private var indexOfTheOneAndOnlyFaceUpCard: Int? {
    get { cards.indices.filter { cards[$0].isFaceUp }.only }
    set {
      for index in cards.indices {
        if cards[index].isFaceUp {
          seenCardsIndicies.insert(index)
        }
        cards[index].isFaceUp = index == newValue
      }
    }
  }
  
  init(cardsContent: [CardContent]) {
    cards = Array<Card>()
    seenCardsIndicies = Set<Int>()
    score = 0
    for content in cardsContent {
      cards.append(Card(id: UUID().uuidString ,content: content))
      cards.append(Card(id: UUID().uuidString ,content: content))
    }
    cards.shuffle()
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
          score += 2
          cards[chosenIndex].isMatch = true
          cards[potentialMatchIndex].isMatch = true
        } else {
          if seenCardsIndicies.contains(chosenIndex) {
            score -= 1
          }
          if seenCardsIndicies.contains(potentialMatchIndex) {
            score -= 1
          }
        }
        cards[chosenIndex].isFaceUp = true
      } else {
        indexOfTheOneAndOnlyFaceUpCard = chosenIndex
      }
    }
  }
}
