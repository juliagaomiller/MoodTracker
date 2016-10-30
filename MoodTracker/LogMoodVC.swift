//
//  LogMoodVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
/*
 TO DOs: 
- to do: outlet for the textfield is customized so user can only write so much (create customTextField?)
- to do: also need to remember to move view up when keyboard is showing up.
 
 commit: "Mood entities are being saved and displayed in day and week tab"
 */


import UIKit
import CoreData

class LogMoodVC: UIViewController, iCarouselDelegate, iCarouselDataSource, NSFetchedResultsControllerDelegate {
    
    //PROPERTIES---------------------------
    @IBOutlet weak var carousel: iCarousel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    //will probably need a custom tf
    @IBOutlet weak var commentaryTF: UITextField!
    
    //All the Mood entities that you have in CoreData.
    static var loggedMoods = [Mood]()
    
    var frc: NSFetchedResultsController<Mood>?

    //Allow for a previous Mood from current day to be updated (like in SomeJunk app).
    var editMood: Mood?
    
    //FUNCTIONS----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carousel.type = .coverFlow2
        carousel.delegate = self
        carousel.dataSource = self
        
        //Actually might need this functions in viewWillAppear? Will see...
        if editMood != nil {
            //scrollToMood(updatePreviousMood)
        }
        //else scrollToMood(nil)
        //change scrollToMostRecentMood so that it takes in a Mood optional to account for updatePreviousMood
        scrollToMostRecentMoodScore()
        
        //This is fine in viewDidLoad because it will keep repeating
        updateDateAndTimeLabels()
        _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.updateDateAndTimeLabels), userInfo: nil, repeats: true)
        
        updateLoggedMoods()
    }
    
    @IBAction func saveMood(_ sender: AnyObject) {
        
        print("COMMENT save pressed.")
        
        //Save the most recent saved mood score to UserDefaults 
        //so that carousel will scroll to this score next time the page loads.
        let index = carousel.currentItemIndex
        UserDefaults.standard.set(index, forKey: "MoodScore")
        
        var mood: Mood!
        
        //if updatePreviousMood is not nil then mood = updatedpreviousmood
        
        mood = Mood(context: delegate.persistentContainer.viewContext)
        mood.score = Int32(index)
        
        if let comment = commentaryTF.text {
            mood.commentary = comment
        }
        
        delegate.saveContext()
        updateLoggedMoods()
        //disable save button for three seconds?
    }
    
    func updateDateAndTimeLabels(){
        let df = DateFormatter()
        df.timeStyle = .short
        
        let timeString = "\(df.string(from: Date()))"
        if timeString != timeLabel.text {
            timeLabel.text = timeString
        }
        df.timeStyle = .none
        df.dateStyle = .long
        let dateString = "\(df.string(from: Date()))"
        if dateString != timeLabel.text {
            dateLabel.text = dateString
        }
        
    }
    
    //Functions involving CoreData.
    func updateLoggedMoods(){
        //Reset fetchedResultsController so that it is empty before you perform the fetch.
        resetFRC()
        
        do {
            try frc?.performFetch()
        } catch {
            let error = error as NSError
            print("COMMENT ERROR performFetch() was not successful. ", error.userInfo)
            return
        }
        
        guard let fetchedObjects = frc?.fetchedObjects else {
            print("COMMENT ERROR There are currently no moods saved.")
            return
        }
        
        LogMoodVC.loggedMoods.removeAll()
        for mood in fetchedObjects {
            LogMoodVC.loggedMoods.append(mood)
            let df = DateFormatter()
            df.timeStyle = .short
            let timeString = df.string(from: mood.date as! Date)
            
            print("COMMENT Time saved ", timeString)
        }
        
        print("COMMENT loggedMoods array count", LogMoodVC.loggedMoods.count)
        
    }
    
    func resetFRC() {
        let request = NSFetchRequest<Mood>(entityName: "Mood")
        let sortByDate = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortByDate]
        let controller = NSFetchedResultsController<Mood>(fetchRequest: request, managedObjectContext: delegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        frc = controller
    }

    //Functions involving iCarousel.
    func scrollToMostRecentMoodScore(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "LaunchedBefore")
        if !launchedBefore {
            print("COMMENT This is first launch.")
            //first launch
            UserDefaults.standard.set(true, forKey: "LaunchedBefore")
            let index: Int = 4
            UserDefaults.standard.set(index, forKey: "MoodScore")
            carousel.scrollToItem(at: index, animated: false)
        } else {
            let index = UserDefaults.standard.integer(forKey: "MoodScore")
            print("COMMENT last logged mood score is", index)
            carousel.scrollToItem(at: index, animated: false)
        }
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 9
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.backgroundColor = UIColor.clear
        let imageView = UIImageView()
        imageView.image = UIImage(named: "\(index)")
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(imageView)

        return view
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return value * 1.1
        }
        return value
    }
}


