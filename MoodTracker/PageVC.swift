//
//  PageVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

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
    }
    
    func checkSwipeDirection(vc: UIViewController, direction: Int) -> UIViewController? {
        guard let currentIndex = VCArray.index(of: vc) else {
            print("PageVC - vc is not in VCArray")
            return nil
        }
        let nextIndex = currentIndex + direction
        guard nextIndex >= 0 else{
            return VCArray.last
        }
        guard nextIndex < VCArray.count else{
            return VCArray.first
        }
//        guard VCArray.count > nextIndex else {
//            return nil
//        }
        return VCArray[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = checkSwipeDirection(vc: viewController, direction: -1)
        return vc
//        guard let currentIndex = VCArray.index(of: viewController) else {
//            return nil
//        }
//        let previousIndex = currentIndex - 1
//        guard previousIndex >= 0 else{
//            return VCArray.last
//        }
//        guard VCArray.count > previousIndex else {
//            return nil
//        }
//        return VCArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = checkSwipeDirection(vc: viewController, direction: 1)
        return vc
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let vc = viewControllers?.first,
            let index = VCArray.index(of: vc) else {
                return 0
        }
        return index
    }


}
