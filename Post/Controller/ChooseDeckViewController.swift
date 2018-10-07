//
//  ChooseDeckViewController.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 05.04.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit
import CoreData

class ChooseDeckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var decksTableView: UITableView!


    var decks: [Deck] = []
    var deckRepository = DeckRepository()

    override func viewDidLoad() {

     /*   let fetchRequest: NSFetchRequest<Decks> = Decks.fetchRequest()
        do {
            let decks = try PersistenceService.context.fetch(fetchRequest)
            self.decks = decks
            self.decksTableView.reloadData()
        } catch {
        }
*/
        decksTableView.delegate = self
        decksTableView.dataSource = self

        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "pattern_leather.png")!)

        deckRepository.getDecksFromUrl(handler: {
            self.decks = $0
            self.decksTableView.reloadData()
            print(self.decks[0].title)
        })
    }


    //----------------------- Работа с таблицей-----------------------------------//

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deckCell", for: indexPath) as! DecksTableViewCell
        let deck = decks[indexPath.row]
        loadImage(cell.deckIcon, deck.image)
        cell.deckName.text = deck.title
        return cell
    }

    private func loadImage(_ imageView: UIImageView!, _ urlString: String) {
        let url = URL(string: urlString)

        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async() {    // execute on main thread
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }


}



