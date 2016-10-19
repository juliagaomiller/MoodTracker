//
//  ReminderVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class ReminderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)

        // Do any additional setup after loading the view.
    }

    //add swipe down recognizer.
    func respondToSwipeGesture(){
        self.dismiss(animated: true, completion: nil)
    }

}
