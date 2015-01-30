//
//  PitchGroup.swift
//  pitchfork
//
//  Created by Jason YeeHarn Jong on 1/30/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import Foundation

struct PitchGroup {
    let category: String
    let description: String
    var pitchVideos:[PitchVideo]
    
    init(category:String, description:String) {
        self.category = category
        self.description = description
        self.pitchVideos = []
    }
    
    mutating func addPitchVideo(pitchVideo:PitchVideo) {
        pitchVideos.append(pitchVideo)
    }
}
