//
//  PitchVideo.swift
//  pitchfork
//
//  Created by Jason YeeHarn Jong on 1/30/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import Foundation

struct PitchVideo {
    var title: String
    var category: String
    let url: String
    var comments:[PitchComment]
    
    //todo
    var upvotes:Int?
    var downvotes:Int?
    
    init(title:String, category:String, url:String) {
        self.title = title
        self.category = category
        self.url = url
        self.comments = []
    }
    
    mutating func addComment(comment:PitchComment) {
        comments.append(comment)
    }
    
    mutating func sortComments() {
        comments.sort { $0.timestamp < $1.timestamp }
    }
}
