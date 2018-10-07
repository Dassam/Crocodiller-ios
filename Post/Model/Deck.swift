//
//  Deck.swift
//  Crocodiller
//
// Created by Яан Прокофьев on 01.04.2018.
// Copyright (c) 2018 YandI. All rights reserved.
//

import UIKit

class Deck: Codable {

    var cardLines: [CardLine] = []
    var title: String = ""
    var pk: Int = 0
    var image: String = ""
    var color: String = ""

    private enum CodingKeys: String, CodingKey {
        case cardLines = "card_lines"
        case title
        case pk
        case image
        case color
    }

}