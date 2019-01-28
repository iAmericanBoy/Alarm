//
//  SwitchTableViewTableViewCell.swift
//  Alarm
//
//  Created by Dominic Lanzillotta on 1/28/19.
//  Copyright © 2019 Dominic Lanzillotta. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func alarmSwitchValueChanged(_ cell: SwitchTableViewCell)
}

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
    weak var delegate: SwitchTableViewCellDelegate?
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.alarmSwitchValueChanged(self)
    }
    
    //MARK: - Privat Methods
    func updateViews() {
        guard let alarm = alarm else {return}
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
    }


}
