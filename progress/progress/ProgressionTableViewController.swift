//
//  MealTableViewController.swift
//  progress
//
//  Created by Thomas Northall-Little on 22/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit
import CoreData
import os.log

class ProgressionTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var goalsList: [TimeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedGoals = loadData() {
            goalsList += savedGoals
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return goalsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ProgressionTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProgressionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let goal = goalsList[indexPath.row]

        cell.nameLabel.text = goal.name
        cell.daysLeft.text = String(getDaysLeft(date: goal.goalDate))
        cell.labelColour.backgroundColor = goal.colour
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            goalsList.remove(at: indexPath.row)
            saveData()
            
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
            print("addItem")
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
            
            let selectedGoal = goalsList[indexPath.row]
            mealDetailViewController.currentGoal = selectedGoal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "")")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ProgressionViewController, let goal = sourceViewController.currentGoal {
            // if editing
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                goalsList[selectedIndexPath.row] = goal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: goalsList.count, section: 0)
                goalsList.append(goal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            saveData()
        }
    }
    
    //MARK: Private Methods
    
    private func getDaysLeft(date: Date) -> Int {
        
        // Day Difference
        let days = Int(date.timeIntervalSinceNow / (60 * 60 * 24))
        
        if days < 0 {
            return -days
        } else {
            return days
        }
    }
    
    //MARK: Data
    private func saveData() {
        NSKeyedArchiver.archiveRootObject(goalsList, toFile: TimeData.ArchiveURL.path)
    }
    
    private func loadData() -> [TimeData]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TimeData.ArchiveURL.path) as? [TimeData]
    }
}
