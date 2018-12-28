//
//  MealTableViewController.swift
//  progress
//
//  Created by Thomas Northall-Little on 22/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit
import os.log

class ProgressionTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var goalsList = [TimeData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedGoals = loadGoals() {
            goalsList += savedGoals
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goalsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProgressionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let goal = goalsList[indexPath.row]
        
        cell.nameLabel.text = goal.name
        cell.daysLeft.text = String(getDaysLeft(date: goal.goalDate))
        
        if goal.goalDate > Date.init() {
            // #70F8BA
//            cell.backgroundColor = UIColor(red:0.44, green:0.97, blue:0.73, alpha:1.0)
        } else {
            // #B8336A
//            cell.backgroundColor = UIColor(red:0.72, green:0.20, blue:0.42, alpha:1.0)
        }
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            goalsList.remove(at: indexPath.row)
            saveMeals()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? ProgressionViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? ProgressionTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "")")
            }
    
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = goalsList[indexPath.row]
            mealDetailViewController.currentGoal = selectedMeal
        
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "")")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ProgressionViewController, let meal = sourceViewController.currentGoal {
            // if editing
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing meal.
                goalsList[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: goalsList.count, section: 0)
                goalsList.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            saveMeals()
            
        }
        
    }
    
    //MARK: Private Methods
    
    private func saveMeals() {
        
        os_log("Meals saving...", log: OSLog.default, type: .debug)

        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(goalsList, toFile: TimeData.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
        
    }
    
    private func loadGoals() -> [TimeData]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TimeData.ArchiveURL.path) as? [TimeData]
    }
    
    private func getDaysLeft(date: Date) -> Int {
        
        // Day Difference
        let days = Int(date.timeIntervalSinceNow / (60 * 60 * 24))
        
        if days < 0 {
            return -days
        } else {
            return days
        }
    }
}
