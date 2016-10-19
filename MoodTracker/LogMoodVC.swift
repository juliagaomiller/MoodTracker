//
//  LogMoodVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
/*
 TO DOs: 
 - prepare views for day and week tab in preparation for saving entity
 - 
 -
 - create reminderVC
 - add swipe down to reminder vc to close it.
 */
//
//commit: "Mood entities are being saved and displayed in day and week tab"

import UIKit

class LogMoodVC: UIViewController, iCarouselDelegate, iCarouselDataSource {
    
    @IBOutlet weak var carousel: iCarousel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carousel.type = .coverFlow2
        carousel.delegate = self
        carousel.dataSource = self
        
        scrollToMostRecentMoodScore()
        
        updateDateAndTimeLabels()
        _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.updateDateAndTimeLabels), userInfo: nil, repeats: true)
    }
    
    @IBAction func saveMood(_ sender: AnyObject) {
        print("saved")
        let index = carousel.currentItemIndex
        UserDefaults.standard.set(index, forKey: "MoodScore")
        
        //CREATE ENTITY
    }
    
    func updateDateAndTimeLabels(){
        let df = DateFormatter()
        df.timeStyle = .short
        
        let timeString = "\(df.string(from: Date()))"
        if timeString != timeLabel.text {
            timeLabel.text = timeString
        }
        df.timeStyle = .none
        df.dateStyle = .long
        let dateString = "\(df.string(from: Date()))"
        if dateString != timeLabel.text {
            dateLabel.text = dateString
        }
        
    }

    //functions involving iCarousel
    
    func scrollToMostRecentMoodScore(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "LaunchedBefore")
        if launchedBefore {
            let index = UserDefaults.standard.integer(forKey: "MoodScore")
            print("last logged mood score:", index)
            carousel.scrollToItem(at: index, animated: false)
        } else {
            //first launch
            UserDefaults.standard.set(true, forKey: "LaunchedBefore")
            let index: Int = 4
            UserDefaults.standard.set(index, forKey: "MoodScore")
            carousel.scrollToItem(at: index, animated: false)
        }
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 9
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.backgroundColor = UIColor.clear
        let imageView = UIImageView()
        imageView.image = UIImage(named: "\(index)")
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(imageView)

        return view
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.1
        }
        return value
    }
}
