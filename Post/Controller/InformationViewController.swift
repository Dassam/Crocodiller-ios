//
//  InformationViewController.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 08.04.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var infoTableView: UITableView!


    var infoLinesText = ["Вступление", "Оценить", "Сайт", "Группа ВКонтакте", "repitch", "yaansaanich"]
    var infoLinesImages = ["PlayImage", "BigThumbUpImage", "InternetImage", "VKImage", "VKImage", "VKImage"]
    var infoLinesUrl = [" ",
                        "https://play.google.com/store/apps/details?id=com.greenlab.crocodiller",
                        "http://winstonvk.github.io/CrocoDiller/",
                        "https://vk.com/crocodiller",
                        "https://vk.com/ilyapya",
                        "https://vk.com/yaansaanich"]

    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.delegate = self
        infoTableView.dataSource = self

        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(patternImage: UIImage(named: "pattern_leather.png")!)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoLinesText.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.imageView?.image = UIImage(named: infoLinesImages[indexPath.row])
        cell.textLabel?.text = infoLinesText[indexPath.row]
        cell.backgroundColor = .clear

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        } else {
            UIApplication.shared.openURL(NSURL(string: infoLinesUrl[indexPath.row])! as URL)
        }
    }


}
