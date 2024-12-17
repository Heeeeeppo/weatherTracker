//
//  HomeViewController.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/15/24.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private let homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = homeView
        homeViewModel.delegate = self
        homeView.delegate = self
//        homeViewModel.removeData()
        homeViewModel.loadSavedWeather()
    }
}

//MARK: - HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func showSearchResult(_ data: Data, _ weather: WeatherModel) {
        homeView.searchResult = weather
        homeView.weatherData = data
    }
    
    func loadSavedWeather(_ weather: WeatherModel?) {
        homeView.loadSavedWeather(with: weather)
    }
}

//MARK: - HomeViewSearchBarDelegate

extension HomeViewController: HomeViewSearchBarDelegate {
    func didTapSearchResult(data: Data) {
        homeViewModel.saveWeather(with: data)
    }
    
    func didEndEditing(with cityName: String) {
        homeViewModel.fetchWeather(city: cityName)
    }
}
