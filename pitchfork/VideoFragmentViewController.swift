//
//  PTTFragmentViewController.swift
//  sonic
//
//  Created by Jason YeeHarn Jong on 1/27/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class VideoFragmentViewController : FragmentViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var titleLabel: UILabel!

    var moviePlayer : MPMoviePlayerController?
    @IBOutlet weak var videoHoldingView: UIView!
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    // Datatypes
    var pitchVideo : PitchVideo?
    
    @IBOutlet weak var commentTextField: UITextField!
    
    func textFieldDidBeginEditing(textField:UITextField) {
        if (textField.text.rangeOfString("Comment at ") != nil) {
            textField.text = ""
            textField.textColor = UIColor.blackColor() //optional
        }
        
        moviePlayer!.pause()
        textField.becomeFirstResponder()
    }
    
    @IBAction func textFieldDiDEndOnExit(sender: AnyObject) {
        var textField:UITextField = sender as UITextField
        
        var interval:NSTimeInterval = moviePlayer!.currentPlaybackTime;
        let playbackTime = interval.description
        
        if (countElements(textField.text) != 0) {
            // submit code
            pitchVideo?.addComment(PitchComment(comment:textField.text, timestamp:Int((playbackTime as NSString).floatValue)))
            pitchVideo?.sortComments()
            commentsTableView.reloadData()
        }
        textField.text = "Comment at " + StringUtils.timeFormatted(Int((playbackTime as NSString).floatValue))
        
        textField.textColor = UIColor.lightGrayColor()
        
        moviePlayer!.play()
        textField.resignFirstResponder()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let video = self.pitchVideo {
            return video.comments.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = commentsTableView.dequeueReusableCellWithIdentifier("CommentCell") as CommentTableCell?
        if (cell == nil) {
            cell = CommentTableCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CommentCell")
        }
        
        cell!.commentItem = self.pitchVideo!.comments[indexPath.row]
        
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.114, green:0.639, blue: 0.984, alpha:0.5)
        cell?.selectedBackgroundView = bgColorView
        return cell!
    }

    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentTextField.delegate = self
        self.commentTextField.text = "Comment at 00:00"
        self.commentTextField.textColor = UIColor.lightGrayColor()
        titleLabel.text = pitchVideo!.title
        
        playVideo()
        
        var updateVideoTime = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateVideoTime"), userInfo: nil, repeats: true)
    }
    
    func updateVideoTime() {
        var interval:NSTimeInterval = moviePlayer!.currentPlaybackTime;
        
        let playbackTime = interval.description
        let timestamp:Int = Int((playbackTime as NSString).floatValue)
        if (commentTextField.text.rangeOfString("Comment at ") != nil) {
            commentTextField.text = "Comment at " + StringUtils.timeFormatted(timestamp)
            commentTextField.textColor = UIColor.lightGrayColor() //optional
        }
        
        // scroll to relevant position for tableView
        let index:Int = getMostRelevantComment(timestamp)
        let indexPath = NSIndexPath(forRow:index, inSection: 0)
        commentsTableView!.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        commentsTableView!.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Top)
    }
    
    func getMostRelevantComment(currentTimestamp:Int) -> Int {
        var i:Int = 0
        for comment:PitchComment in pitchVideo!.comments {
            if currentTimestamp <= comment.timestamp {
                return i
            }
            i++
        }
        
        return pitchVideo!.comments.count - 1
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
