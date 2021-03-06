//
//  PitchItem.swift
//  pitchfork
//
//  Created by Jessica Liu on 1/29/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import Foundation
import UIKit

struct PitchItem {
    enum PitchCategory {
        case Publishing
        case DataViz
        case DigitalPlatform
        case Networking
        case Education
        case International
        case Social
        
        func toString() -> String {
            switch self {
            case .Publishing:
                return "Publishing"
            case .DataViz:
                return "Data Visualization"
            case .DigitalPlatform:
                return "Digital Platform"
            case .Networking:
                return "Networking"
            case .Education:
                return "Education"
            case .International:
                return "International"
            case .Social:
                return "Social"
            }
            
        }
        
        func toColor() -> UIColor {
            switch self {
            case .Publishing:
                return UIColor(red: 0.106, green: 0.686, blue: 0.125, alpha: 1)
            case .DataViz:
                return UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: 1)
            case .DigitalPlatform:
                return UIColor(red: 0.322, green: 0.459, blue: 0.984, alpha: 1)
            case .Networking:
                return UIColor(red: 0.502, green: 0.290, blue: 0.984, alpha: 1)
            case .Education:
                return UIColor(red: 0.988, green: 0.271, blue: 0.282, alpha: 1)
            case .International:
                return UIColor(red: 0.620, green: 0.776, blue: 0.153, alpha: 1)
            case .Social:
                return UIColor(red: 0.820, green: 0.476, blue: 0.153, alpha: 1)
            }
        }
    }
    
    let category: PitchCategory
    let summary: String
}