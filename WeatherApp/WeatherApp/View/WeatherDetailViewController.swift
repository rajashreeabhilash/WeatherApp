//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by AADM504 on 28/3/21.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var lastUpdatedDate: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    var viewModel: WeatherDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    func setUpViewModel(with suburb:WeatherInfoModel) {
        viewModel = WeatherDetailViewModel(with: suburb)
    }
    
    private func setupViews() {
        let suburb = viewModel.suburb
        name.text = suburb.name
        condition.text = suburb.condition
        temperature.text = suburb.temperature
        feelsLikeLabel.text = suburb.feelsLike
        humidityLabel.text = suburb.humidity
        windLabel.text = suburb.wind
        let dateformatter = DateFormatter.ddMMYYYY
        lastUpdatedDate.text = dateformatter.string(from: suburb.updatedDate ?? Date()) 
    }
}
