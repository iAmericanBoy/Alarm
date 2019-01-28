//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    //MARK: - Outlets
    @IBOutlet weak var enableButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    
    //MARK: - Properties
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    var alarmIsOn = true
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Alarm"
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let alarmName = nameTextField.text else {return}
        if let alarm = alarm {
            //update
            AlarmController.shared.update(alarm: alarm, withName: alarmName, fireDate: alarmDatePicker.date, enabled: alarmIsOn)
        } else {
            //newAlarm
            AlarmController.shared.addAlarmWith(name: alarmName, fireDate: alarmDatePicker.date, enabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func enableButtonTapped(_ sender: UIButton) {
        switch enableButton.title(for: .normal) {
            case "On":
                enableButton.setTitle("Off", for: .normal)
                alarmIsOn = false
            case "Off":
                enableButton.setTitle("On", for: .normal)
                alarmIsOn = true
            case "Enable":
                enableButton.setTitle("On", for: .normal)
                alarmIsOn = true
            default:
                break
        }

    }
    
    //MARK: - private Functions
    private func updateViews() {
        guard let alarm = alarm else {return}
        self.title = ""
        nameTextField.text = alarm.name
        alarmDatePicker.date = alarm.fireDate
        alarmIsOn = alarm.enabled
        if alarm.enabled {
            enableButton.setTitle("On", for: .normal)
        } else {
            enableButton.setTitle("Off", for: .normal)
        }
    }
}
