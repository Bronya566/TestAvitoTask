//
//  CardViewController.swift
//  AvitoTest
//
//  Created by Дмитрий on 28.08.2023.
//

import UIKit

final class CardViewController: UIViewController {
 
    private let mainImage = UIImageView()
    
    private let mainTitle = UILabel()
    
    private let priceTitle = {
        let priceTitle = UILabel()
        priceTitle.text = "45 900"
        priceTitle.font = .boldSystemFont(ofSize: 20)
        return priceTitle
    }()
    
    private let locationTitle = {
       let locationTitle = UILabel()
        locationTitle.text = "Moscow"
        return locationTitle
    }()
    
    private let createdDate = {
       let createdDate = UILabel()
        createdDate.text = "10.09.22"
        return createdDate
    }()
    
    private let descriptionTitle = {
       let description = UILabel()
        description.text = "Товар отличный, мне нравится и это главное!"
        return description
    }()
    
    private let emailTitle = {
       let email = UILabel()
        email.text = "qwerty@mail.ru"
        return email
    }()
    
    private let phoneTitle = {
       let phone = UILabel()
        phone.text = "8922988718"
        return phone
    }()
    
    private let addressTitle = {
        let address = UILabel()
        address.text = "Сухаревская улица, дом 45"
        return address
    }()
    
    init(image: UIImage, title: String) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        mainImage.image = image
        mainTitle.text = title
        mainTitle.font = .systemFont(ofSize: 20)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(mainImage)
        view.addSubview(mainTitle)
        view.addSubview(priceTitle)
        view.addSubview(locationTitle)
        view.addSubview(createdDate)
        view.addSubview(descriptionTitle)
        view.addSubview(emailTitle)
        view.addSubview(phoneTitle)
        view.addSubview(addressTitle)
    }
    
    private func setupConstraints() {
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        priceTitle.translatesAutoresizingMaskIntoConstraints = false
        locationTitle.translatesAutoresizingMaskIntoConstraints = false
        createdDate.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        emailTitle.translatesAutoresizingMaskIntoConstraints = false
        phoneTitle.translatesAutoresizingMaskIntoConstraints = false
        addressTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: view.frame.size.width/2),
            mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor),
            
            priceTitle.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 10),
            priceTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            priceTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            priceTitle.heightAnchor.constraint(equalToConstant: 20),
            
            mainTitle.topAnchor.constraint(equalTo: priceTitle.bottomAnchor, constant: 10),
            mainTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            mainTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            mainTitle.heightAnchor.constraint(equalToConstant: 20),
            
            locationTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 10),
            locationTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            locationTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            locationTitle.heightAnchor.constraint(equalToConstant: 20),
            
            addressTitle.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 10),
            addressTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            addressTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            addressTitle.heightAnchor.constraint(equalToConstant: 20),
            
            
            phoneTitle.topAnchor.constraint(equalTo: addressTitle.bottomAnchor, constant: 10),
            phoneTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            phoneTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            phoneTitle.heightAnchor.constraint(equalToConstant: 20),
            
            emailTitle.topAnchor.constraint(equalTo: phoneTitle.bottomAnchor, constant: 10),
            emailTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            emailTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            emailTitle.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionTitle.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: 20),
            descriptionTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            descriptionTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            descriptionTitle.heightAnchor.constraint(equalToConstant: 20),
            
            createdDate.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 20),
            createdDate.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            createdDate.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            createdDate.heightAnchor.constraint(equalToConstant: 20),
            createdDate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
