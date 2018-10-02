//
//  PlayersValidator.swift
//  Crocodiller
//
// Created by Яан Прокофьев on 04.04.2018.
// Copyright (c) 2018 YandI. All rights reserved.
//

import UIKit

class PlayersValidator {

    var playerType: PlayerType = PlayerType.solo
    static let minSoloPlayers = 3
    static let minTeams = 2
    static let maxPlayers = 7

    func setPlayerType(playerType: PlayerType) {
        self.playerType = playerType
    }

    func lessThenMinimumPlayers(players: [Player]) -> Bool {
        if (playerType == PlayerType.solo) {
            return players.count < PlayersValidator.minSoloPlayers
        } else {
            return players.count < PlayersValidator.minTeams
        }
    }

    func moreThenMaximumPlayers(players: [Player]) -> Bool {
        return players.count >= PlayersValidator.maxPlayers
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