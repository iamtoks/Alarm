//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by adetokunbo babatunde on 6/8/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    enum Section: Int {
        case date
        case name
        case button
    }
    
    var alarm: Alarm?
    //MARK- Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var alarmButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Actions
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else {return}
        AlarmController.toggleEnabled(for: alarm)
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if alarm != nil {
            let datepicked = datePicker.date
            let isEnabled = alarmButton.isEnabled
            guard let alarmName = alarmNameTextField.text, let theAlarm = alarm else {return}
            AlarmController.shared.update(alarm: theAlarm, fireDate: datepicked, name: alarmName, enabled: isEnabled)
        } else {
            let datePicked = datePicker.date
            let isEnabled = alarmButton.isEnabled
            guard let alarmName = alarmNameTextField.text else {return}
            AlarmController.shared.addAlarm(fireDate: datePicked, name: alarmName, enabled: isEnabled)
        }
    
    }
    
    // MARK: - Helper Functions
  private func updateViews() {
    guard let alarm = alarm else {return}
    alarmNameTextField.text = alarm.name
    datePicker.date = alarm.fireDate
    
    if alarm.isOn {
        alarmButton.setTitle("Enabled", for: .normal)
    } else {
        alarmButton.setTitle("Disable", for: .normal)
    }
    }
    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch Section(rawValue: indexPath.section) {
//        case .date:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
//            let date = datePicker.date
//
//        case .name:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
//            let name = AlarmController.shared.alarms[indexPath.row]
//            cell.textLabel?.text = name.name
//        case .button:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath)
//
//        }
//
//
//        // Configure the cell...
//
//        return cell
//    }
//
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
