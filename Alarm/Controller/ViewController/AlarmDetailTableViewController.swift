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
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func eneableButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - private Functions
    private func updateViews() {
        guard let alarm = alarm else {return}
        nameTextField.text = alarm.name
        alarmDatePicker.date = alarm.fireDate
        if alarm.enabled {
            enableButton.setTitle("On", for: .normal)
        } else {
            enableButton.setTitle("Off", for: .normal)
        }
    }
}
