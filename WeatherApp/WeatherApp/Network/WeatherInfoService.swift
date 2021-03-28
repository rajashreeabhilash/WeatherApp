//
//  WeatherInfoService.swift
//  WeatherApp
//
//  Created by Rajashree on 28/3/21.ß
//

import Foundation

class WeatherInfoService: NSObject, URLSessionDelegate, URLSessionDataDelegate  {
    var baseUrlString = "https://dnu5embx6omws.cloudfront.net/venues/weather.json"
    var dataTask : URLSessionDataTask?
    var errorMessage = ""
    
    func getSuburbsList(completion: @escaping ([WeatherInfoModel]?, String) -> Void) {
        //Cancel any task if it was running
        dataTask?.cancel()
        
        if let urlComponents = URLComponents(string: baseUrlString) {
            guard let url = urlComponents.url else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let defaultUrlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
            dataTask = defaultUrlSession.dataTask(with: request) {[weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                
                if let error = error {
                    self?.errorMessage += "Error retrieving weather info:" + error.localizedDescription
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    //Form the model class on successful server response
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.ddMMYYYY)
                    if let weatherInfo = try? decoder.decode(WeatherInfoResponse.self, from: data) {
                        completion(weatherInfo.suburbsList, self?.errorMessage ?? "")
                    } else {
                        completion([], self?.errorMessage ?? "")
                    }
                }
            }
            
            //Start the data task
            dataTask?.resume()
        }
    }

    //MARK: - URLSessionData Delegate
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        completionHandler(URLSession.ResponseDisposition.allow)
    }
}

// MARK: - Dateformatter

extension DateFormatter {
  static let ddMMYYYY: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm a d MMMM yyyy"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
