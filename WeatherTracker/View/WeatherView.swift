//
//  WeatherView.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/14/24.
//

import UIKit

class WeatherView: UIView {
    private let iconView = UIImageView()
    
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(600))
        label.textColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70, weight: UIFont.Weight(500))
        label.textColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 44/255.0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humidityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Humidity"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        label.textColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 1)
        return label
    }()
    
    private let humidityDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(500))
        label.textColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1)
        return label
    }()
    
    private let humidityWrapper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2.0
        return stackView
    }()
    
    private let uvTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "UV"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        label.textColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 1)
        return label
    }()
    
    private let uvDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(500))
        label.textColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1)
        return label
    }()
    
    private let uvWrapper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2.0
        return stackView
    }()
    
    private let feelsLikeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels Like"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(500))
        label.textColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 1)
        return label
    }()
    
    private let feelsLikeDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(500))
        label.textColor = UIColor(red: 154/255.0, green: 154/255.0, blue: 154/255.0, alpha: 1)
        return label
    }()
    
    private let feelsLikeWrapper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2.0
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 46.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let infoContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        mainStackView.addArrangedSubviews([iconView, cityNameLabel, temperatureLabel])
        humidityWrapper.addArrangedSubviews([humidityTitleLabel, humidityDataLabel])
        uvWrapper.addArrangedSubviews([uvTitleLabel, uvDataLabel])
        feelsLikeWrapper.addArrangedSubviews([feelsLikeTitleLabel, feelsLikeDataLabel])
        infoStackView.addArrangedSubviews([humidityWrapper, uvWrapper, feelsLikeWrapper])
        infoContainer.addSubview(infoStackView)
        addSubview(mainStackView)
        addSubview(infoContainer)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 46),
            mainStackView.widthAnchor.constraint(equalToConstant: 204),
            mainStackView.heightAnchor.constraint(equalToConstant: 261),
            
            infoContainer.topAnchor.constraint(equalTo: self.mainStackView.bottomAnchor, constant: 35),
            infoContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoContainer.widthAnchor.constraint(equalToConstant: 274),
            infoContainer.heightAnchor.constraint(equalToConstant: 75),
            
            infoStackView.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 16),
            infoStackView.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -16),
            infoStackView.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -16),
            
            iconView.widthAnchor.constraint(equalToConstant: 123),
            iconView.heightAnchor.constraint(equalToConstant: 113)
        ])
    }
    
    func updateView(with weather: WeatherModel) {
        DispatchQueue.main.async {
            self.iconView.setImage(from: "https:\(weather.iconURL)")
            self.cityNameLabel.text = weather.cityName
            self.temperatureLabel.text = "\(weather.temp)º"
            self.humidityDataLabel.text = "\(weather.humidity)%"
            self.uvDataLabel.text = "\(weather.uvIndex)"
            self.feelsLikeDataLabel.text = "\(weather.feelsLikeTemp)º"
        }
    }
}
