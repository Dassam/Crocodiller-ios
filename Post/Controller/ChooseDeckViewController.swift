//
//  ChooseDeckViewController.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 05.04.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit


class ChooseDeckViewController: UIViewController {

    var deckRepository = DeckRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "pattern_leather.png")!)
        deckRepository.getDecksFromUrl(handler: ChooseDeckViewController.onDecksReceived)
    }

    class func onDecksReceived(decks: [Deck]){
        print(decks[0].title)
    }

}
