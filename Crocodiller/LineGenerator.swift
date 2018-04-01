//
//  LineGenerator.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 01.04.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit

class LineGenerator {

    let cardLines: [CardLine] = [
        CardLine.init(word: "гореть", points: 5),
        CardLine.init(word: "сабля", points: 3),
        CardLine.init(word: "горка", points: 2),
        CardLine.init(word: "кулак", points: 4),
        CardLine.init(word: "нет", points: 1)
    ]

    var cardLinesActive: [CardLine] = []

    init() {
        regenerate()
    }

    func regenerate(){
        cardLinesActive = cardLines
    }

    func hasAnyLine() -> Bool {
        return  (cardLinesActive.count > 0 )
    }

    func nextLine() -> CardLine{
        var index = arc4random_uniform(UInt32(cardLinesActive.count));
        return cardLinesActive.remove(at: Int(index))
    }

    func getAvailableLineCount()-> Int{
        return cardLinesActive.count
    }
}
