//
//  DateExtension.swift
//  MoodTracker
//
//  Created by Julia Miller on 11/2/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation

extension Date {
    func getDayOfWeek() -> Int {
        let index = Calendar.current.component(.weekday, from: self as Date)
        return index
    }
    func convertDateToMonthDayString() -> String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.dateFormat = "MM/d"
        let d = df.string(from: self as Date)
        return d
    }
    func getSevenDays() -> [Date] {
        let cal = Calendar.current
        let x = self.getDayOfWeek()-1
        let monday = cal.date(byAdding: .day, value: -x, to: self)
        var array = [Date]()
        array.append(monday!)
        for i in 1...6 {
            let day = cal.date(byAdding: .day, value: i, to: monday!)
            array.append(day!)
        }
        return array
    }
    func findMood(inArray array: [WeekMood]) -> WeekMood? {
        let findThis = self.convertDateToMonthDayString()
        for mood in array {
            if findThis == mood.date {
                let found = mood
                return found
            }
            else {
                return nil
            }
        }
        print("COMMENT ERROR Could not find mood.")
        return nil
    }
    func returnProperWeekArray(array: [WeekMood]) -> ([WeekMood?]) {
        let dates = self.getSevenDays()
        var moodArray = [WeekMood?]()
        for date in dates {
            let found = date.findMood(inArray: array)
            if found != nil {
                moodArray.append(found!)
            } else {
                var notFound = WeekMood()
                notFound.isEmpty(date: date)
                moodArray.append(notFound)
            }
        }
        return moodArray
    }
}
