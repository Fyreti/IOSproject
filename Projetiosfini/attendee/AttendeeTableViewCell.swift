//
//  AttendeeTableViewCell.swift
//  Projetiosfini
//
//  Created by user187202 on 3/24/21.
//

import UIKit

class AttendeeTableViewCell: UITableViewCell {

    @IBOutlet weak var speaking: UILabel?
    @IBOutlet weak var compagnie: UILabel?
    @IBOutlet weak var email: UILabel?
    @IBOutlet weak var numero: UILabel?
    @IBOutlet weak var nom: UILabel?
    @IBOutlet weak var role: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
