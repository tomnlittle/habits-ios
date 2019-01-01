//
//  ProgressionViewController.swift
//  progress
//
//  Created by Thomas Northall-Little on 22/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit
import CoreData
import os.log

class ProgressionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    @IBOutlet weak var goalsTable: UITableView!
    
    var goalsList: [TimeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsTable.delegate = self
        goalsTable.dataSource = self

        
        if let savedGoals = loadData() {
            goalsList += savedGoals
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ShowDetail" {
            guard let detailViewController = segue.destination as? GoalViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }

            guard let selectedCell = sender as? ProgressionTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "")")
            }

            guard let indexPath = goalsTable.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }

            let selectedGoal = goalsList[indexPath.row]
            detailViewController.currentGoal = selectedGoal
        }
    }
    
    //MARK: Actions
    
    @IBAction func unwindToGoalList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? GoalViewController, let goal = sourceViewController.currentGoal {

            // if editing
            if let selectedIndexPath = goalsTable.indexPathForSelectedRow {
                goalsList[selectedIndexPath.row] = goal
                goalsTable.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: goalsList.count, section: 0)
                goalsList.append(goal)
                goalsTable.insertRows(at: [newIndexPath], with: .automatic)
            }

            saveData()
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ProgressionTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProgressionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TableViewCell.")
        }

        // Fetches the appropriate goal for the data source layout.
        let goal = goalsList[indexPath.row]

        cell.addGoalInformation(goal: goal)

        return cell
    }
    
    // Support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    // Support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    @IBAction func animateAdd(_ sender: UIButton) {
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: { (finished: Bool) -> Void in
            sender.layer.removeAllAnimations()
            sender.transform = CGAffineTransform.identity
        })
    }
    
    //MARK: Private Methods
    
    //MARK: Data
    private func saveData() {
        NSKeyedArchiver.archiveRootObject(goalsList, toFile: TimeData.ArchiveURL.path)
    }
    
    private func loadData() -> [TimeData]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TimeData.ArchiveURL.path) as? [TimeData]
    }
}
