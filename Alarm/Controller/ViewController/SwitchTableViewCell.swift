//
//  SwitchTableViewTableViewCell.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
    }
    
    //MARK: - Privat Methods
    func updateViews() {
        guard let alarm = alarm else {return}
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
    }


}
