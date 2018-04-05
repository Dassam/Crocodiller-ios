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
    @IBOutlet var multiPlaeyrGameButton: UIButton!


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

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "pattern_leather.png")!)
    }

    @IBAction func addPlayer(_ sender: Any) {
        print("Добавил игрока")
        if (playersValidator?.moreThenMaximumPlayers(players: players))! {
            let alert = UIAlertController(title: nil, message: "Игроков не может быть больше 7", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Добавить игрока", message: nil, preferredStyle: .alert)
            alert.addTextField() { (playerTF) in
                playerTF.placeholder = "Введите имя игрока"
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
                    let alert = UIAlertController(title: nil, message: "Имя игрока не может быть пустым", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }

            }))

            alert.addAction(UIAlertAction(title: "Закрыть", style: .default))

            self.present(alert, animated: true, completion: nil)
        }
    }


    @IBAction func nextVC(_ sender: UIButton) {

        if (playersValidator?.lessThenMinimumPlayers(players: players))! {
            let alert = UIAlertController(title: nil, message: "Чтобы начать игру нужно минимум 3 игрока", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else if (playersValidator?.IdenticalNames(players: players))! {
            let alert = UIAlertController(title: nil, message: "Имена ироков не могут совпадать", preferredStyle: .alert)
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

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }

        //PersistenceService.context.delete(object)
        //PersistenceService.context.save(updatedObject)﻿


        self.players.remove(at: indexPath.row)
        PersistenceService.saveContext()
        playersTableView.deleteRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: nil, message: "Редактировать имя игрока", preferredStyle: .alert)
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
}
