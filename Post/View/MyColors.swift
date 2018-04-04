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

}
