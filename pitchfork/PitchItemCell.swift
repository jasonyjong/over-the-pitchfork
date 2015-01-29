//
//  PitchItemCell.swift
//  pitchfork
//
//  Created by Jessica Liu on 1/29/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//
import UIKit

class PitchItemCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var pitchItem: PitchItem? {
        didSet {
            if let item = pitchItem {
                categoryLabel.text = item.category.toString()
                categoryLabel.textColor = item.category.toColor()
                summaryLabel.text = item.summary
            }
            else {
                categoryLabel.text = nil
                summaryLabel.text = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}