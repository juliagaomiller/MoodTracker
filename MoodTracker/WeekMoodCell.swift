//
//  WeekMoodCell.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/29/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class WeekMoodCell: UITableViewCell {

    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayAverageImage: UIImageView!
    @IBOutlet weak var numberOfEdits: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var invisibleBtn: UIButton!
    
    @IBAction func pressed(_ sender: AnyObject) {
        //
    }
    
    func configureCell(mood: Mood){
        let df = DateFormatter()
        df.dateStyle = .short
        dateLabel.text = df.string(from: mood.date as! Date)
        guard let image = UIImage(named: "\(mood.score)") else {
            print("COMMENT ERROR could not find image named", mood.score)
            return
        }
        dayAverageImage.image = image
    }

}
