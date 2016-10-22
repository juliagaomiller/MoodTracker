//
//  WeekVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class WeekVC: UITableViewController {
    
    //brainstorm...what if we loaded all of the Mood entities the moment the app turned on;
    //So no filter. 
    //that way, they will populate the calendar.
    
    //array[m, t, w, th, f, s, su]
    
    //var highlightedDate

    override func viewDidLoad() {
        super.viewDidLoad()
        //highlightedDate = static.displayedDate
        //loadNewDate(static.displayedDate)
    }
    
    /*
     func everytime the tab switches back to week tab, check if universal displayedDate has changed
     if displayedDate != highlightedDate
     loadNewdate
     
 */
    
    /*
     func loadNewDate() {
     determine which day of the week it is...
     
     }
 */

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    //number of cells will be array.count
    
    
    /*
     what each cell will look like at index
     the label on the far left will have the array[index]
    */
    
    

  

}
