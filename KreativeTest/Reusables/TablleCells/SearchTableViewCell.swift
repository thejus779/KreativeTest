//
//  MovieTableViewCell.swift
//  KreativeTest
//
//  Created by thejus manoharan on 26/06/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
