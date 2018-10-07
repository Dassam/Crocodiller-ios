//
//  MyColor.swift
//  Crocodiller
//
// Created by Яан Прокофьев on 31.03.2018.
// Copyright (c) 2018 YandI. All rights reserved.
//

import UIKit

extension UIColor {

    class var colorPrimary: UIColor {
        return UIColor(red: 55.0 / 255.0, green: 151.0 / 255.0, blue: 95.0 / 255.0, alpha: 1.0)
    }

    class var colorPrimaryDark: UIColor {
        return UIColor(red: 51.0 / 255.0, green: 139.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    }

    class var colorAccent: UIColor {
        return UIColor(red: 230.0 / 255.0, green: 115.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
    }

    class var colorRed: UIColor {
        return UIColor(red: 174.0 / 255.0, green: 39.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }

    class var colorRedTransparent: UIColor {
        return UIColor(red: 174.0 / 255.0, green: 39.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.7)
    }

    class var error: UIColor {
        return UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
                red: (rgb >> 16) & 0xFF,
                green: (rgb >> 8) & 0xFF,
                blue: rgb & 0xFF
        )
    }

}
