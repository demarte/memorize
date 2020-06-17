//
//  MemoryGame.swift
//  Momorize
//
//  Created by Ivan on 23/05/20.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
  
  private(set) var cards: Array<Card>
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
      !cards[chosenIndex].isMatched {
      
      if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
        if cards[chosenIndex].content == cards[potentialMatchIndex].content {
          cards[chosenIndex].isMatched = true
          cards[potentialMatchIndex].isMatched = true
          if cards[chosenIndex].hasEarnedBonus || cards[potentialMatchIndex].hasEarnedBonus {
            score += 3
          } else {
            score += 2
          }
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

  struct Card: Identifiable {
    let id: String
    let content: CardContent

    var isFaceUp = false {
      didSet {
        if isFaceUp {
          startUsingBonusTime()
        } else {
          stopUsingBonusTime()
        }
      }
    }

    var isMatched = false {
      didSet {
        stopUsingBonusTime()
      }
    }

    // MARK: - Bonus Time -

    // this could give matching bonus points
    // if the user matches the card
    // before a certain amount of time passes during which the card is face up

    // can be zero with means "no bonus available" for this card
    var bonusTimeLimit: TimeInterval = 6

    // the last time this card was turned face up (and still face up)
    var lastTimeFaceUp: Date?
    // the accumulated time this card has been face up in the past
    // (i.e. not including the current time it's been face up if it is currently so)
    var pastFaceUpTime: TimeInterval = 0

    // how long this card has ever been face up
    private var faceUpTime: TimeInterval {
      if let lastFaceUpDate = self.lastTimeFaceUp {
        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
      } else {
        return pastFaceUpTime
      }
    }

    // how much time left before the bonus opportunity runs out
    var bonusTimeRemaining: TimeInterval {
      max(0, bonusTimeLimit - faceUpTime)
    }

    // percentage of bonus time remaining
    var bonusRemaining: Double {
      (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
    }

    // whether the card was matched during the bonus time period
    var hasEarnedBonus: Bool {
     isMatched && bonusTimeRemaining > 0
    }

    // whether we are currently face up, unmatched and have not yet used up the bonus window
    var isConsumingBonusTime: Bool {
      isFaceUp && !isMatched && bonusTimeRemaining > 0
    }

    // called when the card transitions to face up state
    private mutating func startUsingBonusTime() {
      if isConsumingBonusTime, lastTimeFaceUp == nil {
        lastTimeFaceUp = Date()
      }
    }

    // called when the card goes back down (or gets matched)
    private mutating func stopUsingBonusTime() {
      pastFaceUpTime = faceUpTime
      self.lastTimeFaceUp = nil
    }
  }
}
