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
    
    
    /*
     time out!
     when you come back scroll right and read and follow atomicproject instructions. the project xcode is to your left. 
 
 */
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        for view in self.view.subviews {
//            if view is UIScrollView {
//                view.frame = UIScreen.main.bounds
//            } else if view is UIPageControl {
//                print("Bounds: ", view.bounds)
//                view.tintColor = UIColor.black
//                print("Tint = ", view.tintColor)
//                view.backgroundColor = UIColor.clear
//                let horizontal = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
//                let top = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 100)
//                NSLayoutConstraint.activate([horizontal, top])
//                view.translatesAutoresizingMaskIntoConstraints = false
////                print("page control constraints", view.constraints)
//            }
//        }
//    }
    
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
