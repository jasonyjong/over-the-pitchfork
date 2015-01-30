//
//  PTTFragmentViewController.swift
//  sonic
//
//  Created by Jason YeeHarn Jong on 1/27/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoFragmentViewController : FragmentViewController {
    @IBOutlet weak var titleLabel: UILabel!

    var moviePlayer : MPMoviePlayerController?
    @IBOutlet weak var videoHoldingView: UIView!
    
    // Datatypes
    var pitchVideo : PitchVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = pitchVideo!.title
        
        playVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playVideo() {
        if let video = pitchVideo {
            var url:NSURL? = NSURL(string: video.url)
            moviePlayer = MPMoviePlayerController(contentURL: url)
            if let player = moviePlayer {
                player.view.frame = videoHoldingView.bounds
                player.prepareToPlay()
                player.scalingMode = .AspectFit
                videoHoldingView.addSubview(player.view)
            }
        }
    }
    
}
