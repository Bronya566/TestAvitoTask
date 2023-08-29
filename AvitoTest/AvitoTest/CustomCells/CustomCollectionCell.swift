//
//  CustomCollectionCell.swift
//  AvitoTest
//
//  Created by Дмитрий on 28.08.2023.
//

import UIKit

final class CustomCollectionCell: UICollectionViewCell {
    
    var tap: ((String) -> Void)?
    
    private var imageLoader: ImageLoaderProtocol?
    
    private let mainImage: UIImageView = {
        let mainImage = UIImageView()
        mainImage.backgroundColor = ColorConstants.loadImageColor
        return mainImage
    }()
    
    private let mainLabel = {
        let mainLabel = UILabel()
        mainLabel.font = .systemFont(ofSize: 20)
        mainLabel.numberOfLines = 2
        return mainLabel
    }()
    
    private let priceLabel = {
        let priceLabel = UILabel()
        priceLabel.font = .boldSystemFont(ofSize: 20)
        return priceLabel
    }()
    
    private let locationLabel = {
        let locationLabel = UILabel()
        locationLabel.font = .systemFont(ofSize: 15)
        locationLabel.textColor = .systemGray
        return locationLabel
    }()
    
    private let dateCreated = {
        let dateCreated = UILabel()
        dateCreated.font = .systemFont(ofSize: 15)
        dateCreated.textColor = .systemGray
        return dateCreated
    }()
    
    private var id = ""
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoader?.stop()
        mainImage.image = nil
        id = ""
        mainLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        dateCreated.text = nil
    }
    
    @objc func nextScreen() {
        tap?(id)
        
    }
    
    func configure(imageLoader: ImageLoaderProtocol) {
        self.imageLoader = imageLoader
    }
    
    func updateCell(model: Announcement) {
        id = model.id
        mainLabel.text = model.title
        priceLabel.text = model.price
        locationLabel.text = model.location
        dateCreated.text = model.createdDate
        imageLoader?.getImage(imageUrl: model.imageURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.mainImage.image = image
            }
        }
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
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Offset.mainImageTopAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Offset.mainImageLeadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: Offset.mainImageTrailingAnchor),
            mainImage.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            mainLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: Offset.labelTopAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: frame.size.height / Offset.mainLabelHeightAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: Offset.labelTopAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: frame.size.height / Offset.labelHeightAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Offset.labelTopAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: frame.size.height / Offset.labelHeightAnchor),
            
            dateCreated.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Offset.labelTopAnchor),
            dateCreated.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor),
            dateCreated.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dateCreated.heightAnchor.constraint(equalToConstant: frame.size.height / Offset.labelHeightAnchor)
        ])
    }
}

private extension CustomCollectionCell {
    enum Offset {
        static let labelTopAnchor: CGFloat = 3
        static let mainImageTopAnchor: CGFloat = 10
        static let mainImageLeadingAnchor: CGFloat = 5
        static let mainImageTrailingAnchor: CGFloat = -5
        static let mainLabelHeightAnchor: CGFloat = 6
        static let labelHeightAnchor: CGFloat = 12
    }
}
