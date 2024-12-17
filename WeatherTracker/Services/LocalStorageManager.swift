//
//  LocalStorageManager.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/15/24.
//

import Foundation

class LocalStorageManager {
    
    private let savedKey = "savedWeather"
    
    func saveData(with weatherData: WeatherData) {
        do {
            let encodedData = try JSONEncoder().encode(weatherData)
            UserDefaults.standard.set(encodedData, forKey: savedKey)
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func loadData() -> Data? {
        return UserDefaults.standard.data(forKey: savedKey)
    }
    
    func removeData() {
        UserDefaults.standard.removeObject(forKey: savedKey)
    }
}
