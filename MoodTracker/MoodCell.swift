//
//  MoodCell.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/28/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class MoodCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageMood: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    //STRETCH TABLEVIEW TEXT IF THERE IS MORE TEXT
    //ALSO SET A MAX AMOUNT OF CHARACTERS ON THE TEXTFIELD
    //http://stackoverflow.com/questions/25223407/max-length-uitextfield

    @IBAction func save(_ sender: AnyObject) {
    }
    
    func configureCell(mood: Mood){
        let df = DateFormatter()
        df.timeStyle = .short
        timeLabel.text = df.string(from: mood.date as! Date)
        guard let image = UIImage(named: "\(mood.score)") else {
            print("COMMENT ERROR could not find image named", mood.score)
            return
        }
        imageMood.image = image
        guard let comments = mood.commentary else {
            commentLabel.text = "--"
            return
        }
        commentLabel.text = comments
    }

}
