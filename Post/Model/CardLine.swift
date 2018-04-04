//
//  CardLine.swift
//  Crocodiller
//
// Created by Яан Прокофьев on 30.03.2018.
// Copyright (c) 2018 YandI. All rights reserved.
//

import UIKit

class CardLine: Codable {

    let word: String?
    let points: Int?

    init(word: String, points: Int) {
        self.word = word
        self.points = points
    }

    private enum CodingKeys: String, CodingKey {
        case word
        case points = "score"
    }
}