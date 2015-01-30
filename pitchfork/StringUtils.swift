//
//  StringUtils.swift
//  pitchfork
//
//  Created by Jason YeeHarn Jong on 1/30/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import Foundation

class StringUtils {
    
    class func timeFormatted(totalSeconds:Int) -> String {
        
        var seconds:Int = totalSeconds % 60;
        var minutes:Int = (totalSeconds / 60) % 60;
        
        return NSString(format:"%02d:%02d", minutes, seconds);
    }
}