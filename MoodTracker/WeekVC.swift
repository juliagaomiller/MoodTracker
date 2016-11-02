//
//  WeekVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import Darwin

struct Week {
    var su = "Su"
    var m = "M"
    var t = "T"
    var w = "W"
    var th = "Th"
    var f = "F"
    var s = "S"
}

struct WeekMood {
    var image: UIImage?
    var date, score, numberOfCommentary, numberOfEdits: String?
    var weekOfYear: Int?
    mutating func isEmpty(date: Date){
        let date = date
        let string = date.convertDateToMonthDayString()
        self.date = string
        image = nil
        numberOfCommentary = nil
        numberOfEdits = nil
        weekOfYear = nil
    }
    mutating func inArray(moodArray: [Mood?]){
        let d = moodArray.first!?.date
        let date = d as! Date
        let dateTwo = date
        self.date = date.convertDateToMonthDayString()
        weekOfYear = dateTwo.getDayOfWeek()
        if moodArray.count == 0 {
            image = UIImage(named: "placeholder")!
            numberOfCommentary = "--"
            numberOfEdits = "--"
        } else {
            var comments: Int = 0
            var totalScore: Double = 0
            let count = moodArray.count
            for m in moodArray {
                totalScore += Double((m?.score)!)
                if m?.commentary != nil {
                    comments += 1
                }
            }
            let average = round(totalScore/Double(count))
            score = String(average)
            image = UIImage(named: "\(average)")!
            numberOfEdits = String(count)
            numberOfCommentary = String(comments)
        }
    }
}

class WeekVC: UITableViewController {
    
    var sortedMoods = [WeekMood]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let date = DayVC.dateToDisplay as Date
        sortedMoods = sortMoodsAccordingToWeekday(moodArray: LogMoodVC.loggedMoods)
//        let moods = returnProperWeekArray(nsdate: DayVC.dateToDisplay)
        let moods = date.returnProperWeekArray(array: sortedMoods)
        
        print("COMMENT DELETE The number of moods is \(moods.count)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //---Custom Functions---
    
//    func findMood(date: Date, array: [WeekMood]) -> WeekMood? {
//        let findThis = date.convertDateToMonthDayString()
//        for mood in array {
//            if findThis == mood.date {
//                let found = mood
//                return found
//            }
//            else {
//                return nil
//            }
//        }
//        print("COMMENT ERROR Could not find mood.")
//        return nil
//    }
    
//    func returnProperWeekArray(nsdate: NSDate) -> ([WeekMood?]) {
//        let date = nsdate as Date
//        let dates = date.getSevenDays()
//        var moodArray = [WeekMood?]()
//        for date in dates {
//            let found = findMood(date: date, array: sortedMoods)
//            if found != nil {
//                moodArray.append(found!)
//            } else {
//                var notFound = WeekMood()
//                notFound.isEmpty(date: date)
//                moodArray.append(notFound)
//            }
//        }
//        return moodArray
//    }
    
    func sortMoodsAccordingToWeekday(moodArray: [Mood]) -> [WeekMood] {
        var su = [Mood](), m = [Mood](), t = [Mood](), w = [Mood]()
        var th = [Mood](), f = [Mood](), s = [Mood]()
        
        for x in moodArray {
            let date = x.date as! Date
            let string = date.convertDateToMonthDayString()
            let dayOfWeek = date.getDayOfWeek()
            switch(dayOfWeek) {
            case 1:
                su.append(x)
            case 2:
                m.append(x)
            case 3:
                t.append(x)
            case 4:
                w.append(x)
            case 5:
                th.append(x)
            case 6:
                f.append(x)
            case 7:
                s.append(x)
            default:
                print("COMMENT ERROR Weekday error.")
                break
            }
        }
        var weekArray = [WeekMood]()
        for array in [m,t,w,th,f,s,su] {
            if array.count != 0 {
                var mood = WeekMood()
                mood.inArray(moodArray: array)
                weekArray.append(mood)
            }
        }
        return weekArray
    }
    
    //---Tableview Functions---

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedMoods.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}

//---Date Extension---

//extension Date {
//    func getDayOfWeek() -> Int {
//        let date = self
//        let index = Calendar.current.component(.weekday, from: date as Date)
//        return index
//    }
//    func convertDateToMonthDayString() -> String {
//        let date = self
//        let df = DateFormatter()
//        df.dateStyle = .short
//        df.dateFormat = "MM/d"
//        let d = df.string(from: date as Date)
//        return d
//    }
//    func getSevenDays() -> [Date] {
//        let date = self
//        let cal = Calendar.current
//        let i = self.getDayOfWeek()
//        let value = [0 - i, 7 - i]
//        var dateArray = [Date]()
//        for v in value {
//            let x = abs(v)
//            var y: Int = 0
//            while x - y != 0 {
//                let unwrap = cal.date(byAdding: .day, value: x, to: date as Date)
//                guard let day = unwrap else {
//                    print("COMMENT ERROR There was an error retrieving the date.")
//                    return [Date]()
//                }
//                dateArray.append(day)
//                y -= 1
//            }
//        }
//        return dateArray
//    }
//        func findMood(array: [WeekMood]) -> WeekMood? {
//            let date = self
//            let findThis = date.convertDateToMonthDayString()
//            for mood in array {
//                if findThis == mood.date {
//                    let found = mood
//                    return found
//                }
//                else {
//                    return nil
//                }
//            }
//            print("COMMENT ERROR Could not find mood.")
//            return nil
//        }
//    func returnProperWeekArray(array: [WeekMood]) -> ([WeekMood?]) {
//        let date = self
//        let dates = date.getSevenDays()
//        var moodArray = [WeekMood?]()
//        for date in dates {
//            let found = findMood(array: array)
//            if found != nil {
//                moodArray.append(found!)
//            } else {
//                var notFound = WeekMood()
//                notFound.isEmpty(date: date)
//                moodArray.append(notFound)
//            }
//        }
//        return moodArray
//    }
//}
//
//
