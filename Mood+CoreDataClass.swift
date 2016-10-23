//
//  Mood+CoreDataClass.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/22/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


public class Mood: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        let today = NSDate()
        self.date = today
        
        let calendar = NSCalendar(calendarIdentifier: .gregorian)
        guard let day = calendar?.component(.weekday, from: today as Date)
            else { return }
        print("COMMENT weekday: ", day)
        self.weekday = Int32(day)
    }
}
