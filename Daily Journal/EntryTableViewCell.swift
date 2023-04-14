//
//  EntryTableViewCell.swift
//  Daily Journal
//
//  Created by Leandro Farias Lourenco on 03/03/23.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var entryTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
