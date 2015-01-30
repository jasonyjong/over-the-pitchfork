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
    var pitchItems:[PitchItem]
    var myPitchItems:[PitchItem]
    
    init(category:String, description:String) {
        self.category = category
        self.description = description
        self.pitchItems = []
        self.myPitchItems = []
        self.pitchVideos = []
    }
    
    mutating func addPitchVideo(pitchVideo:PitchVideo) {
        pitchVideos.append(pitchVideo)
    }
    
    mutating func addPitchItem(pitchItem:PitchItem) {
        pitchItems.append(pitchItem)
    }
    
    mutating func addMyPitchItem(myPitchItem:PitchItem) {
        myPitchItems.append(myPitchItem)
    }
    
    func getItemAtIndex(index:Int) -> PitchItem {
        return pitchItems[index]
    }
    
    func getMyItemAtIndex(index:Int) -> PitchItem {
        return myPitchItems[index]
    }
    
    func getItemsCount() -> Int {
        return pitchItems.count
    }
    
    func getMyItemsCount() -> Int {
        return myPitchItems.count
    }
    
}
