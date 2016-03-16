//
//  CustomerTableViewCell.swift
//  FormatechCRM
//
//  Created by Nicholas Credli on 3/15/16.
//  Copyright © 2016 Novium Collective SARL. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
