//
//  ViewController.swift
//  pitchfork
//
//  Created by Jason YeeHarn Jong on 1/29/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import UIKit

private let kTableHeaderHeight: CGFloat = 400.0
private let kTableHeaderCutAway: CGFloat = 60.0

class ViewController: UITableViewController, UIScrollViewDelegate {

    @IBOutlet weak var segControl: UISegmentedControl!

    var headerView: UIView!
    var browse = true
    var pitchGroup: PitchGroup?

    var headerMaskLayer: CAShapeLayer!

    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segControl.selectedSegmentIndex
        {
            case 0:
                browse = true
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            case 1:
                browse = false
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            default:
                break
        }
    }
    @IBOutlet weak var textLabel: UILabel!

    let items = [
        PitchItem(category: .Publishing, summary: "Symbolia merges thrilling true stories with amazing illustration and comics."),
        PitchItem(category: .DataViz, summary: "Visualizing Impact captures data through visualization coverage of social issues"),
        PitchItem(category: .DigitalPlatform, summary: "Plympton brings fiction to busy people, make reading in short installments a seamless part of daily life."),
        PitchItem(category: .Networking, summary: "Foreign Policy Interrupted increases the number of women in media commenting on foreign policy issues"),
        PitchItem(category: .Social, summary: "Her Zimbabwe showcases new and social media to promote dialogue among Zimbabwean women."),
        PitchItem(category: .Publishing, summary: "BlogHer features a political blogging network by and for women")
    ]
    
    
    let my_items = [
        PitchItem(category: .Education, summary: "Playfull fosters creativity through collaborative games, educational training, surprise and play"),
        PitchItem(category: .Networking, summary: "PitchCoach helps female journalists with ideas become entrepeneurs with visions."),
    ]
    
    func updateHeaderView() {
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + kTableHeaderCutAway/2
        }
        
        headerView.frame = headerRect
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: 0))
        path.addLineToPoint(CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLineToPoint(CGPoint(x: 0, y: headerRect.height-kTableHeaderCutAway))
        headerMaskLayer?.path = path.CGPath
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pitchGroup = getDummyPitchGroup()
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // allow clickable
        tableView.allowsSelection = true
        
        /*headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        let effectiveHeight = kTableHeaderHeight-kTableHeaderCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.blackColor().CGColor
        
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()*/
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // updateHeaderView()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (context) -> Void in
            [self]
           // self.updateHeaderView()
            self.tableView.reloadData()
            }, completion: { (context) -> Void in
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if browse {
            return pitchGroup!.getItemsCount()
        } else {
            return pitchGroup!.getMyItemsCount()
        }
        /*
        if browse {
            return items.count
        } else {
            return my_items.count
        }*/
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var item: PitchItem
        if browse {
            item = pitchGroup!.getItemAtIndex(indexPath.row)
        } else {
            item = pitchGroup!.getMyItemAtIndex(indexPath.row)
        }
        
        /*if browse {
            item = items[indexPath.row]
        } else {
            item = my_items[indexPath.row]
        }*/
  
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as PitchItemCell
        cell.pitchItem = item
        
        return cell
    }
    
    // function called upon button click event
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath:NSIndexPath) -> NSIndexPath? {
        let viewPagerVC = ViewPagerViewController()
        viewPagerVC.pitchGroup = pitchGroup
        self.presentViewController(viewPagerVC, animated: true, completion: nil)
        return nil
    }
    
    // TODO(jyjong): Enter dummy data here
    func getDummyPitchGroup() -> PitchGroup {
        var pitchGroup:PitchGroup = PitchGroup(category:"Category", description:"This stuff is legit")
        
        var pitchVideo1:PitchVideo = PitchVideo(title: "Symbolia", category: "Publishing", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", desc:"True stories with amazing illustrations")
        var pitchItem1 = PitchItem(category: .Publishing, summary: "Symbolia merges thrilling true stories with amazing illustration and comics.")
        pitchGroup.addPitchVideo(pitchVideo1);
        pitchGroup.addPitchItem(pitchItem1);

        var pitchVideo2:PitchVideo = PitchVideo(title: "Visualizing Impact", category: "DataViz", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", desc:"Visual coverage of social issues")
        var pitchItem2 = PitchItem(category: .DataViz, summary: "Visualizing Impact captures data through visualization coverage of social issues")
        pitchGroup.addPitchVideo(pitchVideo2);
        pitchGroup.addPitchItem(pitchItem2);
        
        var pitchVideo3:PitchVideo = PitchVideo(title: "Foreign Policy Interrupted", category: "Networking", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", desc:"Encourage women in media on foreign policy issues")
        var pitchItem3 = PitchItem(category: .Networking, summary: "Foreign Policy Interrupted increases the number of women in media commenting on foreign policy issues")
        pitchGroup.addPitchVideo(pitchVideo3);
        pitchGroup.addPitchItem(pitchItem3);
        
        var pitchVideo4:PitchVideo = PitchVideo(title: "Plympton", category: "DigitalPlatform", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", desc:"Fiction in small bites")
        var pitchItem4 = PitchItem(category: .DigitalPlatform, summary: "Plympton brings fiction to busy people, make reading in short installments a seamless part of daily life.")
        pitchGroup.addPitchVideo(pitchVideo4);
        pitchGroup.addPitchItem(pitchItem4);
        
        var pitchVideo5:PitchVideo = PitchVideo(title: "Her Zimbabwe", category: "Social", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", desc:"Promoting dialogue among Zimbabwean women")
        var pitchItem5 = PitchItem(category: .Social, summary: "Her Zimbabwe showcases new and social media to promote dialogue among Zimbabwean women.")
        pitchGroup.addPitchVideo(pitchVideo5);
        pitchGroup.addPitchItem(pitchItem5);
        
        var pitchVideo6:PitchVideo = PitchVideo(title: "BlogHer", category: "Publishing", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", desc:"A new political blogging network for women")
        var pitchItem6 = PitchItem(category: .Publishing, summary: "BlogHer features a political blogging network by and for women")
        pitchGroup.addPitchVideo(pitchVideo6);
        pitchGroup.addPitchItem(pitchItem6);
        
        var myPitchVideo1:PitchVideo = PitchVideo(title: "Playfull", category: "Education", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", desc:"Creativity through games and training")
        var myPitchItem1 = PitchItem(category: .Education, summary: "Playfull fosters creativity through collaborative games, educational training, surprise and play")
        pitchGroup.addPitchVideo(myPitchVideo1);
        pitchGroup.addMyPitchItem(myPitchItem1);
        
        var myPitchVideo2:PitchVideo = PitchVideo(title: "PitchCoach", category: "Networking", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", desc:"Learn to pitch your visions")
        var myPitchItem2 = PitchItem(category: .Networking, summary: "PitchCoach helps female journalists with ideas become entrepeneurs with visions.")
        pitchGroup.addPitchVideo(myPitchVideo2);
        pitchGroup.addPitchItem(myPitchItem2);
        
        
        /*
        for (var i = 0; i < 3; i++) {
            var pitchVideo:PitchVideo = PitchVideo(title: "Video " + String(i), category: "Category", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")
            pitchVideo.addComment("This is a comment")
            pitchVideo.addComment("This is another comment")
            pitchGroup.addPitchVideo(pitchVideo)
        }*/
        
        return pitchGroup
    }
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        //updateHeaderView()
    }
}

