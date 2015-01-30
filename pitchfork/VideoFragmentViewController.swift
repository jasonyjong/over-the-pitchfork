//
//  PTTFragmentViewController.swift
//  sonic
//
//  Created by Jason YeeHarn Jong on 1/27/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

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
        println("JAJA")
        if (textField.text.rangeOfString("Comment at ") != nil) {
            textField.text = ""
            textField.textColor = UIColor.blackColor() //optional
        }
        textField.becomeFirstResponder()
    }
    
    @IBAction func textFieldDiDEndOnExit(sender: AnyObject) {
        println("Done")
        var textField:UITextField = sender as UITextField
        if (countElements(textField.text) != 0) {
            // submit code
            pitchVideo?.addComment(textField.text)
            commentsTableView.reloadData()
        }
        
        textField.text = "Comment at "
        textField.textColor = UIColor.lightGrayColor()
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
        return cell!
    }

    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentTextField.delegate = self
        self.commentTextField.text = "Comment at "
        self.commentTextField.textColor = UIColor.lightGrayColor()
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
