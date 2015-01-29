//
//  PTTFragmentViewController.swift
//  sonic
//
//  Created by Jason YeeHarn Jong on 1/27/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import UIKit
import AVFoundation

class VideoFragmentViewController : FragmentViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Page " + String(index())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
