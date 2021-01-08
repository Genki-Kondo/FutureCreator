//
//  SavedCustumCell.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/11/08.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit

class SavedCustumCell: UITableViewCell {

    
    @IBOutlet var studyTypeLabel: UILabel!
    @IBOutlet var studyLanguageLabel: UILabel!
    @IBOutlet var studyTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
