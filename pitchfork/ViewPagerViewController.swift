//
//  ViewController.swift
//  sonic
//
//  Created by Jason YeeHarn Jong on 1/27/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import UIKit

class ViewPagerViewController : UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController?
    var pages:Array<FragmentViewController> = []
    
    // Datatypes
    var pitchGroup:PitchGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "atc", bundle: nil)
        pageViewController = storyboard.instantiateViewControllerWithIdentifier("PageViewController") as UIPageViewController?
        
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        
        var videos:Array<PitchVideo> = pitchGroup!.pitchVideos
        for (var i = 0; i < videos.count; i++) {
            var fragmentVC = storyboard.instantiateViewControllerWithIdentifier("VideoFragmentViewController") as VideoFragmentViewController?
            fragmentVC!.setIndex(i);
            
            fragmentVC!.pitchVideo = videos[i]
            pages.append(fragmentVC!);
        }
        var startingViewController = pages[0]
        pageViewController!.setViewControllers([startingViewController], direction: .Forward, animated:false, completion:nil)
        addChildViewController(pageViewController!)
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers : [VideoFragmentViewController],
        transitionCompleted completed: Bool) {
        
            if completed {
                if let vc = previousViewControllers[0] as VideoFragmentViewController? {
                    vc.stopTimer()
                }
            }
    }
    
    // Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var fragmentVC:FragmentViewController = viewController as FragmentViewController
        return viewControllerAtIndex(fragmentVC.index() - 1)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var fragmentVC:FragmentViewController = viewController as FragmentViewController
        return viewControllerAtIndex(fragmentVC.index() + 1)
    }

    func viewControllerAtIndex(index: Int) -> FragmentViewController? {
        if index < pages.count && index >= 0 {
            return pages[index]
        }
        
        return nil
    }
    
    // Page Indicator
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
