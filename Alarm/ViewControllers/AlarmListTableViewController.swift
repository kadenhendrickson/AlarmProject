//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Kaden Hendrickson on 5/6/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        title = "Alarms"
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedInstance.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmsCell", for: indexPath) as! SwitchTableViewCell
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        cell.updateViews(alarm: alarm)
        cell.delegate = self
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
             let alarmToDelete = AlarmController.sharedInstance.alarms[indexPath.row]
           AlarmController.sharedInstance.delete(alarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let index = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? AlarmDetailTableViewController else {return}
                let alarm = AlarmController.sharedInstance.alarms[index.row]
                destinationVC.alarm = alarm
            }
            
        }
        // Pass the selected object to the new view controller.
    }

}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func toggleSettingFor(cell: SwitchTableViewCell){
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.toggleIsOnFor(alarm: alarm)
        cell.updateViews(alarm: alarm)
    }
}
