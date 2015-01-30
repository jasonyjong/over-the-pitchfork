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
    
    // TODO(jyjong): Change type
    var dataFromVP : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Page " + String(index()) + " " + dataFromVP!
        
        playVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playVideo() {
        // TODO(jyjong): Remove dummy link
        var url:NSURL? = NSURL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")
        moviePlayer = MPMoviePlayerController(contentURL: url)
        if let player = moviePlayer {
            player.view.frame = videoHoldingView.bounds //self.view.bounds
            player.prepareToPlay()
            player.scalingMode = .AspectFill
            videoHoldingView.addSubview(player.view)
        }
    }
    
}
