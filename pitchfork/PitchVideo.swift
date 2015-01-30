//
//  PitchVideo.swift
//  pitchfork
//
//  Created by Jason YeeHarn Jong on 1/30/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import Foundation

struct PitchVideo {
    let title: String
    let url: String
    var comments:[String]
    
    //todo
    let upvotes:Int?
    let downvotes:Int?
    
    init(title:String, url:String) {
        self.title = title
        self.url = url
        self.comments = []
    }
    
    mutating func addComment(comment:String) {
        comments.append(comment)
    }
}
