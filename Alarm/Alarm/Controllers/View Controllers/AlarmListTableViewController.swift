//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by adetokunbo babatunde on 6/8/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AlarmController.shared.loadFromPeristenceStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        cell?.delegate = self
        cell?.updateViews(with: alarm)
        // Configure the cell...

        return cell ?? UITableViewCell()
    }
    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarms = AlarmController.shared.alarms
            let alarmToDelete = alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarmToDelete)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    




    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //IIDOO
        //Identifier
        if segue.identifier == "toAlarmDetailVC" {
            //Index & Destination
            guard let index = tableView.indexPathForSelectedRow, let destination = segue.destination as? AlarmDetailTableViewController else {return}
            //Object to send
            let alarmToSend = AlarmController.shared.alarms[index.row]
            //Object to Set
            destination.alarm = alarmToSend
            
        }
    }
}

extension AlarmListTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
          guard let indexPath = tableView.indexPath(for: cell) else {return}
        let alarmToUpdate = AlarmController.shared.alarms[indexPath.row]
        AlarmController.toggleEnabled(for: alarmToUpdate)
        cell.updateViews(with: alarmToUpdate)
    }
    
    

}
