//
//  FooterView.swift
//  FlightsLocator
//
//  Created by Marcos Garcia on 1/15/19.
//  Copyright © 2019 Marcos Garcia. All rights reserved.
//

import UIKit

class FooterView: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.statusLabel.text = status
        
    }
        

    var status: String?
    
    // this is a convenient way to create this view controller without a imageURL
    convenience init() {
        self.init(status: nil)
    }
    
    init(status: String?) {
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
