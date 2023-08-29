//
//  CustomCollectionCell.swift
//  AvitoTest
//
//  Created by Дмитрий on 28.08.2023.
//

import UIKit

final class CustomCollectionCell: UICollectionViewCell {
    
    var tap: ((UIImage, String) -> Void)?
    
    private let mainImage =  {
        let imageDefault = UIImage(systemName: "person")
        let mainImage = UIImageView(image: imageDefault)
        return mainImage
    }()
    
    private let mainLabel = {
       let mainLabel = UILabel()
        mainLabel.text = "Тестовый товар"
        mainLabel.font = .systemFont(ofSize: 20)
        return mainLabel
    }()
    
    private let priceLabel = {
        let priceLabel = UILabel()
        priceLabel.text = "55.000"
        priceLabel.font = .boldSystemFont(ofSize: 20)
        return priceLabel
    }()
    
    private let locationLabel = {
        let locationLabel = UILabel()
        locationLabel.text = "Москва"
        locationLabel.font = .systemFont(ofSize: 15)
        locationLabel.textColor = .systemGray
        return locationLabel
    }()
    
    private let dateCreated = {
        let dateCreated = UILabel()
        dateCreated.text = "22.04.19"
        dateCreated.font = .systemFont(ofSize: 15)
        dateCreated.textColor = .systemGray
        return dateCreated
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextScreen))
        addGestureRecognizer(tapGestureRecognizer)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func nextScreen() {
        tap?(mainImage.image ?? UIImage(), mainLabel.text ?? " ")
        
    }
    
    
    private func setupUI() {
        contentView.addSubview(mainImage)
        contentView.addSubview(mainLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateCreated)
    }
    
    private func setupConstraints() {
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        dateCreated.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: frame.size.width/2),
            mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor),
            
            mainLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 5),
            mainLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 20),
            
            priceLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            locationLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dateCreated.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            dateCreated.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            dateCreated.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateCreated.heightAnchor.constraint(equalToConstant: 20),
          dateCreated.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

}
