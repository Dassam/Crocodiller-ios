//
//  ChoosePlayersViewController.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 02.04.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit

class ChoosePlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var soloGameImage: UIImageView!
    @IBOutlet var playersTableView: UITableView!
    @IBOutlet var newGameButton: UIButton!
    
    var players = [String]()

    override func viewDidLoad() {

        playersTableView.delegate = self
        playersTableView.dataSource = self

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "pattern_leather.png")!)
    }

    @IBAction func addPlayer(_ sender: Any) {
        print("Добавил игрока")
        if (players.count >= 7) {
            let alert = UIAlertController(title: "Внимание", message: "Игроков не может быть больше 7", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Добавить игрока", message: nil, preferredStyle: .alert)
            alert.addTextField() { (playerTF) in
                playerTF.placeholder = "Введите имя игрока"
            }

            alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in
                guard let player = alert.textFields?.first?.text else {
                    return
                }
                print(player)
                self.players.append(player)
                self.playersTableView.reloadData()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let player = players[indexPath.row]
        cell.textLabel?.text = player

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        players.remove(at: indexPath.row)

        playersTableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
