//
//  CustomTableViewCell.swift
//  BauBuddyTaskList
//
//  Created by Sena Kurtak on 14.02.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var colorCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
