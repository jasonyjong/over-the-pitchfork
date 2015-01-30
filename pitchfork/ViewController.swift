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

    var headerMaskLayer: CAShapeLayer!

    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segControl.selectedSegmentIndex
        {
            case 0:
                browse = true
            case 1:
                browse = false
            default:
                break
        }
    }
    @IBOutlet weak var textLabel: UILabel!

    let items = [
        PitchItem(category: .Publication, summary: "Symbolia merges thrilling true stories with amazing illustration and comics."),

        PitchItem(category: .DataViz, summary: "Interactive way to visualize poll results from elections"),
        PitchItem(category: .DigitalPlatform, summary: "Plympton brings fiction to busy people, make reading in short installments a seamless part of daily life." )
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
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as PitchItemCell
        cell.pitchItem = item
        
        return cell
    }
    
    // function called upon button click event
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath:NSIndexPath) -> NSIndexPath? {
        let viewPagerVC = ViewPagerViewController()
        viewPagerVC.pitchGroup = getDummyPitchGroup()
        self.presentViewController(viewPagerVC, animated: true, completion: nil)
        return nil
    }
    
    // TODO(jyjong): Enter dummy data here
    func getDummyPitchGroup() -> PitchGroup {
        var pitchGroup:PitchGroup = PitchGroup(category:"Category", description:"This stuff is legit")
        
        for (var i = 0; i < 3; i++) {
            var pitchVideo:PitchVideo = PitchVideo(title: "Video " + String(i), category: "Category", url:"http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")
            pitchVideo.addComment("This is a comment")
            pitchVideo.addComment("This is another comment")
            pitchGroup.addPitchVideo(pitchVideo)
        }
        
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

