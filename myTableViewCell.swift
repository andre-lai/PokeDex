//
//  myTableViewCell.swift
//  PokedexLab
//
//  Created by Andre Lai on 3/9/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var stats: UILabel!
    @IBOutlet weak var imageOutlet2: UIImageView!

}
