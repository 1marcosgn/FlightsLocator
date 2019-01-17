//
//  FlightCell.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

class FlightCell: UITableViewCell {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var arrival: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
