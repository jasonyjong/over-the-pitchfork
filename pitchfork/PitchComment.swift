//
//  PitchComment.swift
//  pitchfork
//
//  Created by Jason YeeHarn Jong on 1/30/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import Foundation

struct PitchComment {
    let comment: String
    let timestamp: Int
    
    init(comment:String, timestamp:Int) {
        self.comment = comment
        self.timestamp = timestamp
    }
}
