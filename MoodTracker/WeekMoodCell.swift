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
    
    func configureCell(mood: WeekMood, index: Int){
        var d = ["M", "T", "W", "Th", "F", "S", "Su"]
        weekLabel.text = d[index]
        invisibleBtn.isEnabled = true
        if mood.numberOfCommentary == "0"{
            invisibleBtn.isEnabled = false
        }
        dateLabel.text = mood.date
        dayAverageImage.image = mood.image
        numberOfEdits.text = mood.numberOfEdits
        numberOfComments.text = mood.numberOfCommentary
    }
}
