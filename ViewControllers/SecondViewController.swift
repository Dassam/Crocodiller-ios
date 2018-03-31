//
//  SecondViewController.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 30.03.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var word: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var time: UILabel!
    @IBOutlet var score: UILabel!
    
    var totalScore = 0
    var numberOfSet = 0

    var seconds = 60
    var timer = Timer()

    var cardLines: [CardLine] = [

        CardLine.init(word: "гореть", points: 5),
        CardLine.init(word: "сабля", points: 3),
        CardLine.init(word: "горка", points: 2),
        CardLine.init(word: "кулак", points: 4),
        CardLine.init(word: "нет", points: 1)

    ]


    @objc func counter()
    {
        seconds -= 1
        time.text = String(seconds)

        if (seconds == 0)
        {
            timer.invalidate()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        word.text = cardLines[numberOfSet].word
        points.text = "+" + String(cardLines[numberOfSet].points)
        score.text = "Очки:" +  String(totalScore)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.counter), userInfo: nil, repeats: true)
    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LeftButtonClc(_ sender: Any) {
        timer.invalidate()
        seconds = 60
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.counter), userInfo: nil, repeats: true)

        totalScore = totalScore + cardLines[numberOfSet].points
        numberOfSet = numberOfSet + 1
        word.text = cardLines[numberOfSet].word
        points.text = "+" + String(cardLines[numberOfSet].points)
        score.text = "Очки:" +  String(totalScore)
    }
    
    @IBAction func RightButtonClc(_ sender: Any) {

        timer.invalidate()
        seconds = 60
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.counter), userInfo: nil, repeats: true)

        numberOfSet = numberOfSet + 1
        word.text = cardLines[numberOfSet].word
        points.text = "+" + String(cardLines[numberOfSet].points)
        
    }
    
    
    
}

