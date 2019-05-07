//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Kaden Hendrickson on 5/6/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func toggleSettingFor(cell: SwitchTableViewCell)
}


class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    

    //MARK: Properties
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    func updateViews(alarm: Alarm) {
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
        
        
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.toggleSettingFor(cell: self)
    }
    

}
