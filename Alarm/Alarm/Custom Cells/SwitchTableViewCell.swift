//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by adetokunbo babatunde on 6/8/20.
//  Copyright © 2020 AdetokunboBabatunde. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: AnyObject {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    //MARK: - Delegate
    weak var delegate: SwitchTableViewCellDelegate?
    
    //MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews(with: alarm!)
        }
    }
    // MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    
    }
    
    //MARK: - Helper Functions
    func updateViews(with alarm: Alarm) {
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.isOn
    }
    
 
    
    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
*/
}
