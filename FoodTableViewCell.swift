//
//  FoodTableViewCell.swift
//  FoodCheck
//
//  Created by Jack Scallan on 4/11/21.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
