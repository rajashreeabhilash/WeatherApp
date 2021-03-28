//
//  WeatherInfoViewModel.swift
//  WeatherApp
//
//  Created by Rajashree on 28/3/21.
//

import Foundation

class WeatherInfoViewModel {
    var suburbsList: [WeatherInfoModel] = []
    
    init() {
        let service = WeatherInfoService()
        service.getSuburbsList() { [weak self] (data, message) in
            guard let list = data else { return }
            self?.suburbsList = list
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ListUpdated"), object: self?.suburbsList)
        }
    }
}
