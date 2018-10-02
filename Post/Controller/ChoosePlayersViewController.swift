//
//  ChoosePlayersViewController.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 02.04.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit
import CoreData

class ChoosePlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var playersTableView: UITableView!
    @IBOutlet var newGameButton: UIButton!
    @IBOutlet var addNewPlayerButton: UIBarButtonItem!
    @IBOutlet var soloGameButton: UIButton!
    @IBOutlet var multiPlayerGameButton: UIButton!

    var playerType: PlayerType = PlayerType.solo
    var players = [Player]()
    var playersValidator: PlayersValidator?

    override func viewDidLoad() {

        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()

        do {
            let players = try PersistenceService.context.fetch(fetchRequest)
            self.players = players
            self.playersTableView.reloadData()
        } catch {
        }

        playersTableView.delegate = self
        playersTableView.dataSource = self
        playersValidator = PlayersValidator()
        selectPlayerType(playerType: PlayerType.solo)

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "pattern_leather.png")!)
    }

    @IBAction func addPlayer(_ sender: Any) {

        if (playersValidator?.moreThenMaximumPlayers(players: players))! {
            let alert = UIAlertController(title: nil, message: getMaxPlayerErrorMessage(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: addPlayerMessage(), message: nil, preferredStyle: .alert)
            alert.addTextField() { (playerTF) in
                playerTF.placeholder = self.enterPlayerNameMessage()
            }

            alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in

                if (alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                    guard let name = alert.textFields?.first?.text!.trimmingCharacters(in: .whitespacesAndNewlines) else {
                        return
                    }
                    let player = Player(context: PersistenceService.context)
                    player.name = name
                    PersistenceService.saveContext()
                    self.players.append(player)
                    self.playersTableView.reloadData()
                } else {
                    let alert = UIAlertController(title: nil, message: self.nonEmptyPlayerNameMessage(), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }

            }))

            alert.addAction(UIAlertAction(title: "Закрыть", style: .default))

            self.present(alert, animated: true, completion: nil)
        }
    }


    private func getMaxPlayerErrorMessage() -> String {
        if (playerType == PlayerType.solo) {
            return String(format: "Игроков не может быть больше %d", PlayersValidator.maxPlayers)
        } else {
            return String(format: "Команд не может быть больше %d", PlayersValidator.maxPlayers)
        }
    }

    private func addPlayerMessage() -> String {
        if (playerType == PlayerType.solo) {
            return "Добавить игрока"
        } else {
            return "Добавить команду"
        }
    }

    private func enterPlayerNameMessage() -> String {
        if (playerType == PlayerType.solo) {
            return "Введите имя игрока"
        } else {
            return "Введите название команды"
        }
    }

    private func nonEmptyPlayerNameMessage() -> String {
        if (playerType == PlayerType.solo) {
            return "Имя игрока не может быть пустым"
        } else {
            return "Название команды не может быть пустым"
        }
    }

    private func minPlayerErrorMessage() -> String {
        if (playerType == PlayerType.solo) {
            return String(format: "Чтобы начать игру нужно минимум %d игрока", PlayersValidator.minSoloPlayers)
        } else {
            return String(format: "Чтобы начать игру нужно минимум %d команды", PlayersValidator.minTeams)
        }
    }

    private func matchPlayerErrorMessage() -> String {
        if (playerType == PlayerType.solo) {
            return "Имена ироков не могут совпадать"
        } else {
            return "Название команд не могут совпадать"
        }
    }

    private func editPlayerNameErrorMessage() -> String {
        if (playerType == PlayerType.solo) {
            return "Редактировать имя игрока"
        } else {
            return "Редактировать название команды"
        }
    }

    @IBAction func nextVC(_ sender: UIButton) {

        if (playersValidator?.lessThenMinimumPlayers(players: players))! {
            let alert = UIAlertController(title: nil, message: minPlayerErrorMessage(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else if (playersValidator?.IdenticalNames(players: players))! {
            let alert = UIAlertController(title: nil, message: matchPlayerErrorMessage(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            let resultsVC = storyboard?.instantiateViewController(withIdentifier: "ResultsVC")
            self.navigationController?.pushViewController(resultsVC!, animated: true)
        }

    }

//----------------------- Работа с таблицей-----------------------------------//

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let player = players[indexPath.row].name
        cell.textLabel?.text = player
        cell.backgroundColor = .clear

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PersistenceService.context.delete(players[indexPath.row])

            do {
                players = try PersistenceService.context.fetch(Player.fetchRequest())
            } catch let error as NSError {
                print("Couldn't save \(error), \(error.userInfo)")
            }

            //PersistenceService.saveContext()
        }

        playersTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: editPlayerNameErrorMessage(), preferredStyle: .alert)
        alert.addTextField() { (playerTF) in
            playerTF.text = self.players[indexPath.row].name
        }

        alert.addAction(UIAlertAction(title: "Принять", style: .default, handler: { _ in
            self.players[indexPath.row].name = alert.textFields?.first?.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            PersistenceService.saveContext()
            self.playersTableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))

        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func soloGameSelection(_ sender: UIButton) {
        selectPlayerType(playerType: PlayerType.solo)
    }

    @IBAction func multiPlayerSelection(_ sender: UIButton) {
        selectPlayerType(playerType: PlayerType.team)
    }


    func selectPlayerType(playerType: PlayerType) {
        self.playerType = playerType
        playersValidator?.playerType = playerType
        if (playerType == PlayerType.solo) {
            soloGameButton.alpha = 1
            multiPlayerGameButton.alpha = 0.5
            self.title = "Игроки"
        } else {
            soloGameButton.alpha = 0.5
            multiPlayerGameButton.alpha = 1
            self.title = "Команды"
        }
    }
}
