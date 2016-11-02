//
//  DayVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

class DayVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var averageImg: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    static var dateToDisplay: NSDate!
    
    var allLoggedMoods = [Mood]()
    var moodsOfDay = [Mood]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allLoggedMoods = LogMoodVC.loggedMoods
        DayVC.dateToDisplay = NSDate()
        updateMoodsOfDay()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateMoodsOfDay()
    }
    
    @IBAction func dateAfter(_ sender: AnyObject) {
        //if you're on currentDate then nextDate button is not enabled.
        //if app did not exist before this date, the button is inactive, otherwise you should be able to scroll through ALL the dates from the moment that app is created.
    }
    
    @IBAction func dateBefore(_ sender: AnyObject) {
    }
    
    func updateMoodsOfDay() {
        moodsOfDay.removeAll()
        var score: Double = 0
        for mood in allLoggedMoods {
            if NSCalendar.current.isDate(mood.date as! Date, inSameDayAs: DayVC.dateToDisplay as Date){
                moodsOfDay.append(mood)
                score += Double(mood.score)
            }
        }
        print("COMMENT Moods in moodsODay array:", moodsOfDay.count)
        if moodsOfDay.count == 0 {
            //imageIsSetToDefault
        } else {
            let average = round(score/Double(moodsOfDay.count))
            
            guard let image = UIImage(named: "\(average)") else {
                print("COMMENT ERROR could not find image asset named", average)
                return
            }
            averageImg.image = image
        }
        tableView.reloadData()
    }
    
    func convertDateToString(date: NSDate, getTime: Bool) -> String {
        let df = DateFormatter()
        if getTime {
            df.timeStyle = .short
        } else {
            //Retrieving the date.
            df.dateStyle = .long
        }
        return df.string(from: date as Date)
        
    }
    
    //---TableView Functions---
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = moodsOfDay.count
        if count == 0 {
            //make sure this is an empty cell
            return 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if moodsOfDay.count == 0 {
            let cell = UITableViewCell()
            //dequeue reusablecell with identifier "EmptyCell"
            return cell
        }
        let mood = moodsOfDay[indexPath.row]
        let moodCell = tableView.dequeueReusableCell(withIdentifier: "MoodCell") as! MoodCell
        moodCell.configureCell(mood: mood)
        return moodCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ifyoutapthe tableview cell (should that function be within custom table day cell?
        //if otherDate = nil (then you are on current date) and you can edit any of the moods.
        //segues back to logmoodvc except time is now static on time that it was chosen.
    }

    

}
