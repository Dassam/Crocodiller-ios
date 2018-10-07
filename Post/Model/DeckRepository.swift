//
//  DeckRepository.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 05.10.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import Foundation


class DeckRepository {

    let decoder = JSONDecoder()

    func getDecksFromUrl(handler: @escaping ([Deck]) -> Void) {
        guard let url = URL(string: "http://croco.tunemate.lclients.ru/api/v1/deck/") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do {
                let decks: [Deck] = try self.decoder.decode([Deck].self, from: dataResponse)
                handler(decks)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }

}