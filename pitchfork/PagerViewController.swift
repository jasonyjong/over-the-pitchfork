//
//  ViewController.swift
//  sonic
//
//  Created by Jason YeeHarn Jong on 1/27/15.
//  Copyright (c) 2015 Jason YeeHarn Jong. All rights reserved.
//

import UIKit

class PagerViewController : UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController?
    var pages = [PTTFragmentViewController.self, ReceiverFragmentViewController.self] as Array<FragmentViewController.Type>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "atc", bundle: nil)
        pageViewController = storyboard.instantiateViewControllerWithIdentifier("PageViewController") as UIPageViewController?
        
        pageViewController!.dataSource = self
        
        var startingViewController = viewControllerAtIndex(0)
        pageViewController!.setViewControllers([startingViewController!], direction: .Forward, animated:false, completion:nil)
        addChildViewController(pageViewController!)
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let index = indexOfPageByClass(viewController)
        if index == NSNotFound {
            return nil
        } else {
            return viewControllerAtIndex(index - 1)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let index = indexOfPageByClass(viewController)
        if index == NSNotFound {
            return nil
        } else {
            return viewControllerAtIndex(index + 1)
        }
    }
    
    func indexOfPageByClass(viewController: UIViewController!) -> Int {
        for (var i = 0; i < pages.count; i++) {
            if viewController.isKindOfClass(pages[i]) {
                return i
            }
        }
    
        return NSNotFound
    }
    
    func viewControllerAtIndex(index: Int) -> FragmentViewController? {
        if index < pages.count && index >= 0 {
            return storyboard?.instantiateViewControllerWithIdentifier(pages[index].fragmentStoryboardId()) as FragmentViewController?
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
