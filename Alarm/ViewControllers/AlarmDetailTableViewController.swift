//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Kaden Hendrickson on 5/6/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    //MARK: Properties
    var alarm: Alarm? {
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var enableAlarmButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        title = "Edit Alarms"
        
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else {return}
        AlarmController.sharedInstance.toggleIsOnFor(alarm: alarm)
        updateEnableButton(alarm)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let nameTextField = nameTextField.text else {return}
        if let alarm = alarm {
            AlarmController.sharedInstance.update(alarm: alarm, fireDate: datePicker.date, name: nameTextField, enabled: alarm.enabled)
        } else {
            AlarmController.sharedInstance.addAlarm(fireDate: datePicker.date, name: nameTextField, enabled: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    func updateEnableButton(_ alarm: Alarm) {
       
        if alarm.enabled {
            enableAlarmButton.setTitle("Turn Alarm Off", for: .normal)
            enableAlarmButton.backgroundColor = .red
        } else {
            enableAlarmButton.setTitle("Turn Alarm On", for: .normal)
            enableAlarmButton.backgroundColor = .green
            
        }
    }
    
    private func updateViews() {
        guard let alarm = alarm else {return}
        nameTextField.text = alarm.name
        datePicker.date = alarm.fireDate
        updateEnableButton(alarm)
        
        
    }
    

}
