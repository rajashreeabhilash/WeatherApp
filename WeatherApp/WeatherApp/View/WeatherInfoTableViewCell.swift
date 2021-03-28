//
//  WeatherInfoTableViewCell.swift
//  WeatherApp
//
//  Created by AADM504 on 28/3/21.
//

import UIKit

class WeatherInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    func configure(with item:WeatherInfoModel) {
        name.text = item.name
        condition.text = item.condition ?? "Normal" // TODO: Check - what needs to be displayed if there is no info
        temperature.text = item.temperature ?? "20" // TODO: Check - what needs to be displayed if there is no info
    }
}
