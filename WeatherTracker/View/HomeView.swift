//
//  HomeView.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/14/24.
//

import Foundation
import UIKit

protocol HomeViewSearchBarDelegate {
    func didEndEditing(with cityName: String)
    func didTapSearchResult(data: Data)
}

class HomeView: UIView {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        searchBar.placeholder = "Search Location"
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private let searchResultView = SearchResultView()
    private let weatherView = WeatherView()
    
    private let noCityTitle: UILabel = {
        let label = UILabel()
        label.text = "No City Selected"
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(600))
        label.textColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let noCitySubTitle: UILabel = {
        let label = UILabel()
        label.text = "Please Search For A City"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(600))
        label.textColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    var searchResult: WeatherModel? {
        didSet {
            applyModel()
        }
    }
    
    var weatherData: Data? {
        didSet {
            searchResultView.weatherData = weatherData
        }
    }
    
    var searchResultClick: ()
    
    var delegate: HomeViewSearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .white
        searchResultView.translatesAutoresizingMaskIntoConstraints = false
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        addSubview(searchResultView)
        addSubview(weatherView)
        addSubview(noCityTitle)
        addSubview(noCitySubTitle)
        noCityTitle.isHidden = true
        noCitySubTitle.isHidden = true
        weatherView.isHidden = true
        searchResultView.isHidden = true
        searchBar.delegate = self
        searchResultView.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 44),
            searchBar.heightAnchor.constraint(equalToConstant: 46),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])
    }
    
    private func setupSearchResultView() {
        NSLayoutConstraint.activate([
            searchResultView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 122),
            searchResultView.heightAnchor.constraint(equalToConstant: 117),
            searchResultView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchResultView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        searchResultView.isHidden = false
        weatherView.isHidden = true
        noCityTitle.isHidden = true
        noCitySubTitle.isHidden = true
    }
    
    private func setupWeatherView() {
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 170),
            weatherView.heightAnchor.constraint(equalToConstant: 204),
            weatherView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 56)
        ])
        weatherView.isHidden = false
        searchResultView.isHidden = true
        noCityTitle.isHidden = true
        noCitySubTitle.isHidden = true
    }
    
    private func setupNoCityLabels() {
        NSLayoutConstraint.activate([
            noCityTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 330),
            noCityTitle.widthAnchor.constraint(equalToConstant: 280),
            noCityTitle.heightAnchor.constraint(equalToConstant: 60),
            noCityTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            noCitySubTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 371),
            noCitySubTitle.widthAnchor.constraint(equalToConstant: 280),
            noCitySubTitle.heightAnchor.constraint(equalToConstant: 60),
            noCitySubTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        noCityTitle.isHidden = false
        noCitySubTitle.isHidden = false
        weatherView.isHidden = true
        searchResultView.isHidden = true
    }
    
    private func applyModel() {
        searchResultView.searchResult = searchResult
        searchResultView.weatherData = weatherData
    }
    
    func loadSavedWeather(with weather: WeatherModel?) {
        guard let weather else {
            setupNoCityLabels()
            return
        }
        DispatchQueue.main.async {
            self.setupWeatherView()
            self.weatherView.updateView(with: weather)
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    private func isValidCityName(_ city: String) -> Bool {
        let pattern = "^[a-zA-Z\\s]+$"
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: trimmedCity.count)
        
        return !trimmedCity.isEmpty && regex?.firstMatch(in: trimmedCity, options: [], range: range) != nil
    }
}

//MARK: - UISearchBarDelegate

extension HomeView: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Search Location"
            return false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let cityName = searchBar.text, isValidCityName(cityName) {
            delegate?.didEndEditing(with: cityName)
            setupSearchResultView()
        } else {
            print("invalid City name")
            setupWeatherView()
        }
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // dismiss keyboard
        searchBar.resignFirstResponder()
    }
}

//MARK: - searchResultViewDelegate

extension HomeView: searchResultViewDelegate {
    func didTapSearchResult(data: Data) {
        delegate?.didTapSearchResult(data: data)
        setupWeatherView()
    }
}
