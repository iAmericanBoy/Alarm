//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    //MARK: - LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else {return UITableViewCell()}
        
        cell.alarm = AlarmController.shared.alarms[indexPath.row]
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AlarmController.shared.alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if  segue.identifier == "toDetailTVC" {
            guard let index = tableView.indexPathForSelectedRow else {return}
            if let destinationVC = segue.destination as? AlarmDetailTableViewController {
                destinationVC.alarm = AlarmController.shared.alarms[index.row]
            }
        }
    }
}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func alarmSwitchValueChanged(_ cell: SwitchTableViewCell) {
        guard let alarm = cell.alarm, let index = tableView.indexPath(for: cell) else {return}
        
        
        tableView.beginUpdates()
        AlarmController.shared.toggleEnable(for: alarm)
        tableView.reloadRows(at: [index], with: .automatic)
        tableView.endUpdates()
    }
}
