//
//  WeatherInfoModel.swift
//  WeatherApp
//
//  Created by AADM504 on 28/3/21.
//

import Foundation

struct WeatherInfoModel: Decodable {
    let name: String
    let country: Country
    let condition: String?
    let temperature: String?
    let wind: String?
    let feelsLike: String?
    let humidity: String?
    let updatedDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case country = "_country", name = "_name", temperature = "_weatherTemp", updatedDate = "_weatherLastUpdated"
        case condition = "_weatherCondition", wind = "_weatherWind", feelsLike = "_weatherFeelsLike", humidity = "_weatherHumidity"
    }
}

struct Country: Decodable {
    let name: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_countryID", name = "_name"
    }
}

extension WeatherInfoModel {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.country = try container.decode(Country.self, forKey: .country)
    self.condition = try? container.decodeIfPresent(String.self, forKey: .condition)
    self.temperature = try? container.decodeIfPresent(String.self, forKey: .temperature)
    self.wind = try? container.decodeIfPresent(String.self, forKey: .wind)
    self.feelsLike = try? container.decodeIfPresent(String.self, forKey: .feelsLike)
    self.humidity = try? container.decodeIfPresent(String.self, forKey: .humidity)
    self.updatedDate = try? container.decode(Date.self, forKey: .updatedDate)
//        let formatter = DateFormatter.ddMMYYYY
//        if let date = formatter.date(from: uploadDate) {
//            self.updatedDate = date
//        }
  }
}
