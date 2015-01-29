//
//  FragmentViewController.swift
//  sonic
//
//  Created by Jason YeeHarn Jong on 1/27/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import UIKit

class FragmentViewController : UIViewController {
    
    var mIndex:Int = 0
    
    func setIndex(index:Int) {
        self.mIndex = index
    }
    
    func index() -> Int {
        return mIndex
    }
    
}
