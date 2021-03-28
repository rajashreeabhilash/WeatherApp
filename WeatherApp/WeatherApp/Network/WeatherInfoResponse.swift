//
//  WeatherInfoResponse.swift
//  WeatherApp
//
//  Created by AADM504 on 28/3/21.
//

import Foundation

struct WeatherInfoResponse: Decodable {
    let suburbsList: [WeatherInfoModel]

    enum CodingKeys: String, CodingKey {
        case suburbsList = "data"
    }
}

extension WeatherInfoResponse {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    suburbsList = try container.decode([WeatherInfoModel].self, forKey: .suburbsList)
  }
}
