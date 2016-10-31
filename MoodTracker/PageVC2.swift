//
//  PageVC2.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/22/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class PageVC2: UIViewController, PageVCDelegate {
    
    //There are two pageVCs because we wanted to move the UIPageControl to the top of the page.

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageVC = segue.destination as? PageVC {
            pageVC.pageVCdelegate = self
        }
    }
    
    func pageVC(pageVC: PageVC, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func pageVC(pageVC: PageVC, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}
