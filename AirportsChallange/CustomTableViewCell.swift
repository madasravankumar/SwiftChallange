//
//  CustomTableViewCell.swift
//  AirportsChallange
//
//  Created by Sravan Kumar on 16/06/17.
//  Copyright © 2017 com.honeywell. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var airportName: UILabel!
    @IBOutlet weak var icoLbl: UILabel!
    @IBOutlet weak var latLbl: UILabel!
    @IBOutlet weak var lonLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
