//
//  SearchResultView.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/16/24.
//

import UIKit

protocol searchResultViewDelegate {
    func didTapSearchResult(data: Data)
}

class SearchResultView: UIView {
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 106
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 13
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(600))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: UIFont.Weight(500))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var searchResult: WeatherModel? {
        didSet {
            applyModel()
        }
    }
    
    var weatherData: Data?
    
    var delegate: searchResultViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        verticalStackView.addArrangedSubviews([titleLabel, tempLabel])
        mainStackView.addArrangedSubviews([verticalStackView, iconView])
        addSubview(container)
        container.addSubview(mainStackView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        container.addGestureRecognizer(tapGesture)
        
        setupConstraints()
    }
    
    @objc private func handleTap() {
        if let weatherData {
            delegate?.didTapSearchResult(data: weatherData)
            print("tapped")
            print(weatherData)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            mainStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            
            verticalStackView.widthAnchor.constraint(equalToConstant: 85),
            verticalStackView.heightAnchor.constraint(equalToConstant: 85),
            
            iconView.widthAnchor.constraint(equalToConstant: 83),
            iconView.heightAnchor.constraint(equalToConstant: 67)
        ])
    }
    
    private func applyModel() {
        guard let searchResult else { return }
        DispatchQueue.main.async {
            self.titleLabel.text = searchResult.cityName
            self.tempLabel.text = "\(searchResult.temp)º"
            self.iconView.setImage(from: "https:\(searchResult.iconURL)")
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        
    }
}
