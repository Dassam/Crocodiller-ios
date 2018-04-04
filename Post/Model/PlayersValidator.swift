//
//  PlayersValidator.swift
//  Crocodiller
//
// Created by Яан Прокофьев on 04.04.2018.
// Copyright (c) 2018 YandI. All rights reserved.
//

import UIKit

class PlayersValidator {

    var checkIsOk: Bool?

    func lessThenMinimumPlayers(players: [String]) -> Bool {
        if (players.count < 3) {
            checkIsOk = true
        } else {
            checkIsOk = false
        }
        return checkIsOk!
    }

    func moreThenMaximumPlayers(players: [String]) -> Bool {
        if (players.count >= 7) {
            checkIsOk = true
        } else {
            checkIsOk = false
        }
        return checkIsOk!
    }

    func noEmptyNames(players: [String]) -> Bool {

        return checkIsOk!
    }

    func IdenticalNames(players: [String]) -> Bool {
        checkIsOk = false
        for i in 0...players.count - 2 {
            for j in i + 1...players.count - 1 {
                if (players[i].trimmingCharacters(in: .whitespacesAndNewlines) == players[j].trimmingCharacters(in: .whitespacesAndNewlines)){
                    checkIsOk = true
                    break
                }
            }
        }
        return checkIsOk!
    }
}