//
//  NewsViewCell.swift
//  TestApp
//
//  Created by Santanu Koley on 23/07/18.
//  Copyright © 2018 Santanu Koley. All rights reserved.
//

import UIKit

class NewsViewCell: UITableViewCell {
    @IBOutlet weak var labelHeadLine: UILabel!
    @IBOutlet weak var labelNewsCoverBy: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageProfileView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
