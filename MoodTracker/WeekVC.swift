//
//  WeekVC.swift
//  MoodTracker
//
//  Created by Julia Miller on 10/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class WeekVC: UITableViewController {
    
    private var daysOfWeek = ["M","T","W","Th","F","S","Su"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //---Tableview Functions---

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }

}
