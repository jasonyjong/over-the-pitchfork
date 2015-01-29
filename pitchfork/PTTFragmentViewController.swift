//
//  PTTFragmentViewController.swift
//  sonic
//
//  Created by Jason YeeHarn Jong on 1/27/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import UIKit
import AVFoundation

class PTTFragmentViewController : FragmentViewController {
    
    var currentFilePath:String?

    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordingButton: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    var recordSettings = [
        AVFormatIDKey: kAudioFormatAppleLossless,
        AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
        AVEncoderBitRateKey : 320000,
        AVNumberOfChannelsKey: 2,
        AVSampleRateKey : 44100.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // removed deprecated AVAudioSessionDelegate protocol
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        /* TODO (jyjong): Actually set permissions when prod
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted {
                println("Granted")
            } else {
                println("Permission to record not granted")
            }
        }) */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override class func fragmentStoryboardId() -> String {
        return "PTTFragmentViewController"
    }
    
    @IBAction func onTouchDownRecordButton(sender: AnyObject) {
        let recordButton = sender as UIButton
        recordButton.backgroundColor = .blueColor()
        recordButton.setTitle("Recording", forState: .Normal)
        
        self.setFilePath();
        recordOrStop(currentFilePath!);
    }
    
    // TODO(jyjong): Change to hashed audio recording.
    func setFilePath() {
        if currentFilePath == nil {
                currentFilePath = NSTemporaryDirectory().stringByAppendingPathComponent ("recordedFile.caf")
        }
    }
    
    @IBAction func onTouchUpRecordButton(sender: AnyObject) {
        let recordButton = sender as UIButton;
        recordButton.backgroundColor = .blackColor()
        recordButton.setTitle("Press to Record", forState: .Normal)
        
        recordOrStop(currentFilePath!);
    }
    
    @IBAction func onTouchUpPlayButton(sender: AnyObject) {
        playOrPause(currentFilePath!);
    }
    
    @IBAction func onTouchUpRandomButton(sender: AnyObject) {
        let filePath = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent("tmp0.caf")
        playOrPause(filePath)
    }
    
    func recordOrStop(filePath: String) {
        if audioRecorder != nil && audioRecorder!.recording {
            audioRecorder!.stop()
        } else {
            let audioUrl = NSURL(fileURLWithPath: filePath);
            var error:NSError?
            audioRecorder = AVAudioRecorder(URL: audioUrl, settings: recordSettings, error: &error)
            if let e = error {
                println(e.localizedDescription)
            }
            audioRecorder!.record()
        }
    }
    
    func playOrPause(filePath: String) {
        if audioPlayer != nil && audioPlayer!.playing {
            audioPlayer!.pause()
        } else {
            let audioUrl = NSURL(fileURLWithPath: filePath);
            var error:NSError?
            audioPlayer = AVAudioPlayer(contentsOfURL: audioUrl, error: &error)
            if let e = error {
                println(e.localizedDescription)
            } else {
                audioPlayer!.prepareToPlay()
                audioPlayer!.play()
            }
        }
    }
}
