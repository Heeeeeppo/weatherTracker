//
//  WeatherService.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/14/24.
//

import Foundation

class WeatherManager {
    let baseURL = Constants.API.baseURL
    let apiKey = Constants.API.apiKey
    
    func fetchWeather(cityName: String, completion: @escaping (Result<(Data, WeatherModel), Error>) -> Void) {
        let urlString = "\(baseURL)?key=\(apiKey)&q=\(cityName)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            if let data {
                do {
                    let weather = try self.parseJSON(data)
                    completion(.success((data, weather)))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    public func parseJSON(_ weatherData: Data) throws -> WeatherModel {
        let decoder = JSONDecoder()
        let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
        let cityName = decodeData.location.name
        let temp = decodeData.current.temp
        let iconURL = decodeData.current.condition.icon
        let humidity = decodeData.current.humidity
        let uvIndex = decodeData.current.uvIndex
        let feelsLikeTemp = decodeData.current.feeksLiksTemp
        return WeatherModel(
            cityName: cityName,
            temp: temp,
            iconURL: iconURL,
            humidity: humidity,
            uvIndex: uvIndex,
            feelsLikeTemp: feelsLikeTemp
        )
    }
}
