//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by AADM504 on 28/3/21.
//

import Foundation

class WeatherDetailViewModel {
    let suburb: WeatherInfoModel
    
    init(with suburb:WeatherInfoModel) {
        self.suburb = suburb
    }
}
