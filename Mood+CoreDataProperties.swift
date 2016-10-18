//
//  Mood+CoreDataProperties.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/18/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension Mood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mood> {
        return NSFetchRequest<Mood>(entityName: "Mood");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var score: Int16
    @NSManaged public var commentary: String?

}
