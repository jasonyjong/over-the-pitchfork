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
    var description: String
    let url: String
    var comments:[String]
    
    //todo
    var upvotes:Int?
    var downvotes:Int?
    
    init(title:String, category:String, url:String, desc:String) {
        self.title = title
        self.description = desc
        self.category = category
        self.url = url
        self.comments = []
    }
    
    mutating func addComment(comment:String) {
        comments.append(comment)
    }
}
