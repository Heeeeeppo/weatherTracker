//
//  WeatherData.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/14/24.
//

import Foundation

struct WeatherData: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
}

struct Current: Codable {
    let temp: Double
    let condition: Condition
    let humidity: Int
    let feeksLiksTemp: Double
    let uvIndex: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case condition
        case humidity
        case feeksLiksTemp = "feelslike_c"
        case uvIndex = "uv"
    }
}

struct Condition: Codable {
    let icon: String
}
