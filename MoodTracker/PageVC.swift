//
//  PageVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//
// Note: link below helped a lot with figuring out how to move the UIPageControl.
//https://spin.atomicobject.com/2016/02/11/move-uipageviewcontroller-dots/

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDataSource {
    
    weak var pageVCdelegate: PageVCDelegate?

    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(storyID: "LogMoodVC"),
                self.VCInstance(storyID: "TabBarVC"),
                self.VCInstance(storyID: "AnalysisVC")]
    }()
    
    private func VCInstance(storyID: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyID)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = VCArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        pageVCdelegate?.pageVC(pageVC: self, didUpdatePageCount: VCArray.count)
    }
    
    func checkSwipeDirection(vc: UIViewController, direction: Int) -> UIViewController? {
        guard let currentIndex = VCArray.index(of: vc) else {
            print("PageVC - vc is not in VCArray")
            return nil
        }
        let nextIndex = currentIndex + direction
        guard nextIndex >= 0 else{
            return nil
                //VCArray.last
        }
        guard nextIndex < VCArray.count else{
            return nil
                //VCArray.first
        }
        return VCArray[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = checkSwipeDirection(vc: viewController, direction: -1)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = checkSwipeDirection(vc: viewController, direction: 1)
        return vc
    }
}

extension PageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let firstViewController = viewControllers?.first,
            let index = VCArray.index(of: firstViewController)
            else {
                return
        }
        pageVCdelegate?.pageVC(pageVC: self, didUpdatePageIndex: index)
    }
}

protocol PageVCDelegate: class {
    
    func pageVC(pageVC: PageVC, didUpdatePageCount count: Int)
    
    func pageVC(pageVC: PageVC, didUpdatePageIndex index: Int)
}
