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
    
    var meals = [TimeData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            loadSampleMeals()
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
        return self.meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProgressionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
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
            meals.remove(at: indexPath.row)
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
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "")")
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ProgressionViewController, let meal = sourceViewController.meal {
            // if editing
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing meal.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            saveMeals()
            
        }
        
    }
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
//        let photo1 = UIImage(named: "meal1")
//        let photo2 = UIImage(named: "meal2")
//        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = TimeData(name: "Caprese Salad", photo: nil, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = TimeData(name: "Chicken and Potatoes", photo: nil, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = TimeData(name: "Pasta with Meatballs", photo: nil, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }
        
        meals += [meal1, meal2, meal3]
    }
    
    private func saveMeals() {
        
        os_log("Meals saving...", log: OSLog.default, type: .debug)

        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: TimeData.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
        
    }
    
    private func loadMeals() -> [TimeData]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TimeData.ArchiveURL.path) as? [TimeData]
    }
}
