//
//  DecksTableViewCell.swift
//  Crocodiller
//
//  Created by Яан Прокофьев on 07.10.2018.
//  Copyright © 2018 YandI. All rights reserved.
//

import UIKit

class DecksTableViewCell: UITableViewCell {
    @IBOutlet var deckIcon: UIImageView!
    @IBOutlet var deckName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
