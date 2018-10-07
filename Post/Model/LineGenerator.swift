//
//  LineGenerator.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 01.04.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit

class LineGenerator {

    let cardLines: [CardLine]

    let deckJSON = """
{
  "card_lines": [
    {
      "pk": 126,
      "word": "кулич",
      "score": 2
    },
    {
      "pk": 127,
      "word": "улитка",
      "score": 2
    },
    {
      "pk": 128,
      "word": "консистенция",
      "score": 5
    },
    {
      "pk": 129,
      "word": "креветка",
      "score": 3
    },
    {
      "pk": 130,
      "word": "коммунизм",
      "score": 5
    }
  ]
}
""".data(using: .utf8)!

    var cardLinesActive: [CardLine] = []

    init() {

        do {
            let decoder = JSONDecoder()
            let deck: Deck = try decoder.decode(Deck.self, from: deckJSON)
            cardLines = deck.cardLines
            regenerate()
        } catch let err {
            print("Err", err)
            cardLines = []
        }

    }

    func regenerate() {
        cardLinesActive = cardLines
    }

    func hasAnyLine() -> Bool {
        return (cardLinesActive.count > 0)
    }

    func nextLine() -> CardLine {
        let index = arc4random_uniform(UInt32(cardLinesActive.count));
        return cardLinesActive.remove(at: Int(index))
    }

    func getAvailableLineCount() -> Int {
        return cardLinesActive.count
    }
}
