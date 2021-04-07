//
//  SponsorsTableViewCell.swift
//  Projetiosfini
//
//  Created by user187202 on 3/31/21.
//

import UIKit

class SponsorsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var sponsorContact: UILabel?
    @IBOutlet weak var sponsorNote: UILabel?
    @IBOutlet weak var sponsorAmount: UILabel?
    @IBOutlet weak var sponsorName: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
