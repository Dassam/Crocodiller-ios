//
//  Deck.swift
//  Crocodiller
//
// Created by Яан Прокофьев on 01.04.2018.
// Copyright (c) 2018 YandI. All rights reserved.
//

import UIKit

class Deck: Codable {

    let cardLines: [CardLine]

    private enum CodingKeys: String, CodingKey {
        case cardLines = "card_lines"
    }

}