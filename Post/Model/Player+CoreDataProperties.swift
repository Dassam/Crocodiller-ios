//
//  Player+CoreDataProperties.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 04.04.2018.
//  Copyright © 2018 YandI. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?

}
