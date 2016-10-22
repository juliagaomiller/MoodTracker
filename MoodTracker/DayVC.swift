//
//  DayVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

class DayVC: UIViewController {
    
    //create a static var otherDate (i think thats what you call it if you want other vcs to be able to access it)
    //var currentDate: NSDate!
    //var displayedDate: NSDate!
    
    //lazy var frc to retrieve from core data the moods. 
    //then try to put this moodArray into a static var that can be accessed by weekVC and dayVC.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //always start on this page if you just opened app.
        
        //let currentDate = NSDate()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        displayMoodData()
    }
    
    
    func displayMoodData(){
        /*
         if let date = otherDate {
         displayedDate = date
         } else {
         displayedDate = currentDate
         date on top = currentDate.day, week, month
         var mood array = frc objects.
         IF frc objects returns nothing {
         set the display to default (placeholder in average imagebox) placeholders in tablecell 
         YOU WILL NEED TO CREATE A CUSTOM TABLEVIEW CELL TO HOLD IMAGE, time, commentary if there is any, and button option to place in analysis.
         ELSE for loop through moodArray
         for each one create a customTableViewCell
 */
    }
    
    //when you press these you must update the otherdate.
    //@IBAction nextDate: if you're on currentDate then nextDate button is not enabled.
    //@IBAction previousDate: if app did not exist at the date, the button is inactive, otherwise you should be able to scroll through ALL the dates from the moment that app is created.
    
    /*func ifyoutapthe tableview cell (should that function be within custom table day cell?
    if otherDate = nil (then you are on current date) and you can edit any of the moods.
     segues back to logmoodvc except time is now static on time that it was chosen.
    */

    

}
