//
//  WeekVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

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
    var weekOfYear: Int
    init(moodArray: [Mood]) {
        let d = moodArray.first!.date
        let df = DateFormatter()
        df.dateStyle = .short
        df.dateFormat = "MM/d"
        date = df.string(from: d as! Date)
        weekOfYear = Calendar.current.component(.weekOfYear, from: d as! Date)
        if moodArray.count == 0 {
            image = UIImage(named: "placeholder")!
            numberOfCommentary = "--"
            numberOfEdits = "--"
        } else {
            var comments: Int = 0
            var totalScore: Double = 0
            let count = moodArray.count
            for m in moodArray {
                totalScore += Double(m.score)
                if m.commentary != nil {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        sortedMoods = sortMoodsAccordingToWeekday(moodArray: LogMoodVC.loggedMoods)
        for x in sortedMoods {
            print("The average mood for \(x.date) is \(x.score)")
        }
    }
    
    func sortMoodsAccordingToWeekday(moodArray: [Mood]) -> [WeekMood] {
        var su = [Mood](), m = [Mood](), t = [Mood](), w = [Mood]()
        var th = [Mood](), f = [Mood](), s = [Mood]()
        for x in moodArray {
            let dayOfWeek = Calendar.current.component(.weekday, from: x.date as! Date)
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
                let mood = WeekMood(moodArray: array)
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
