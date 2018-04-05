//
//  PlayersValidator.swift
//  Crocodiller
//
// Created by Яан Прокофьев on 04.04.2018.
// Copyright (c) 2018 YandI. All rights reserved.
//

import UIKit

class PlayersValidator {


    func lessThenMinimumPlayers(players: [Player]) -> Bool {
        return players.count < 3
    }

    func moreThenMaximumPlayers(players: [Player]) -> Bool {
        return players.count >= 7
    }

    func IdenticalNames(players: [Player]) -> Bool {
        var checkFailed = false
        for i in 0...players.count - 2 {
            for j in i + 1...players.count - 1 {
                if (players[i].name! == players[j].name!) {
                    checkFailed = true
                    break
                }
            }
        }
        return checkFailed
    }
}