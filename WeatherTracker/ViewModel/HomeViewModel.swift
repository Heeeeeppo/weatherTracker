//
//  HomeViewModel.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/14/24.
//

import Foundation

protocol HomeViewModelDelegate {
    func loadSavedWeather(_ weather: WeatherModel?)
//    func didFailWithError
    func showSearchResult(_ data: Data, _ weather: WeatherModel)
}

class HomeViewModel {
    private let weatherManager: WeatherManager
    private let localStorageManager: LocalStorageManager
    
    var delegate: HomeViewModelDelegate?
    
    init(weatherManager: WeatherManager, localStorageManager: LocalStorageManager) {
        self.weatherManager = weatherManager
        self.localStorageManager = localStorageManager
    }
    
    func loadSavedWeather() {
        guard let savedWeather = localStorageManager.loadData() else {
            delegate?.loadSavedWeather(nil)
            return
        }
        do {
            let weatherModel = try weatherManager.parseJSON(savedWeather)
            delegate?.loadSavedWeather(weatherModel)
        } catch {
            print("Error loading data: \(error.localizedDescription)")
        }
    }
    
    func fetchWeather(city: String) {
        weatherManager.fetchWeather(cityName: city) { [weak self] result in
            switch result {
            case .success(let (data, weather)):
                self?.delegate?.showSearchResult(data, weather)
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
    }
    
    func saveWeather(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: data)
            localStorageManager.saveData(with: decodeData)
            loadSavedWeather()
        } catch {
            print("Error decoding data when saving: \(error.localizedDescription)")
        }
    }
    
    func removeData() {
        localStorageManager.removeData()
    }
}
