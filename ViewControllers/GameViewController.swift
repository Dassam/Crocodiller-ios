//
//  GameViewController.swift
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

    var seconds = 60
    var timer = Timer()

    var lineGenerator : LineGenerator = LineGenerator()
    var currentCardLine : CardLine!

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

        lineGenerator = LineGenerator()
        
        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "pattern_leather.png")!)

        currentCardLine = lineGenerator.nextLine()

        word.text = currentCardLine.word
        points.text = "+" + String(currentCardLine.points!)
        score.text = "Очки:" +  String(totalScore)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.counter), userInfo: nil, repeats: true)
    }


    func newWordSelection() {

        timer.invalidate()
        time.text = "60"
        seconds = 60
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SecondViewController.counter), userInfo: nil, repeats: true)

        if (!lineGenerator.hasAnyLine()) {
            let alert = UIAlertController(title: "Конец", message: "Спасибо за игру", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)

        } else {
            currentCardLine = lineGenerator.nextLine()
            word.text = currentCardLine.word
            points.text = "+" + String(currentCardLine.points!)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LeftButtonClc(_ sender: Any) {

        totalScore = totalScore + currentCardLine.points!

        newWordSelection()

        score.text = "Очки:" +  String(totalScore)
    }
    
    @IBAction func RightButtonClc(_ sender: Any) {

        newWordSelection()
        
    }
    
    
    
}

