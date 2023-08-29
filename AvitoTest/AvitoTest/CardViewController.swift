//
//  CardViewController.swift
//  AvitoTest
//
//  Created by Дмитрий on 28.08.2023.
//

import UIKit

final class CardViewController: UIViewController {
    
    private var models: [CardModel] = []
    private let networkService: NetworkServiceProtocol
    private let alertFactory: AlertFactoryProtocol
    
    private let mainImage = UIImageView()
    
    private let mainTitle = UILabel()
    
    private let priceTitle = {
        let priceTitle = UILabel()
        priceTitle.numberOfLines = 0
        priceTitle.font = .boldSystemFont(ofSize: 20)
        return priceTitle
    }()
    
    private let locationTitle = {
        let locationTitle = UILabel()
        locationTitle.numberOfLines = 0
        return locationTitle
    }()
    
    private let createdDate = {
        let createdDate = UILabel()
        createdDate.numberOfLines = 0
        return createdDate
    }()
    
    private let descriptionTitle = {
        let description = UILabel()
        description.numberOfLines = 0
        return description
    }()
    
    private let emailTitle = {
        let email = UILabel()
        email.numberOfLines = 0
        return email
    }()
    
    private let phoneTitle = {
        let phone = UILabel()
        phone.numberOfLines = 0
        return phone
    }()
    
    private let addressTitle = {
        let address = UILabel()
        address.numberOfLines = 0
        return address
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height * 1.2)
    }
    
    private let id: String
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = view.bounds
        activityIndicator.color = UIColor.gray
        return activityIndicator
    }()
    
    private lazy var errorView = CustomAlertView(frame: view.bounds)
    
    init(id: String, netwrokService: NetworkServiceProtocol, alertFactory: AlertFactoryProtocol) {
        self.networkService = netwrokService
        self.id = id
        self.alertFactory = alertFactory
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        mainTitle.font = .systemFont(ofSize: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorView.delegate = self
        errorView.isHidden = true
        activityIndicator.startAnimating()
        startLoad()
        setupUI()
        setupConstraints()
    }
    
    private func startLoad() {
        errorView.isHidden = true
        networkService.getCurrentCard(id: id)  { [weak self] card in
            switch card {
            case .success(let card):
                DispatchQueue.main.async {
                    self?.updateCard(model: card)
                    self?.activityIndicator.stopAnimating()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert()
                    self?.activityIndicator.stopAnimating()
                    self?.errorView.isHidden = false
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = alertFactory.makeAlert { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.startLoad()
        }
        mainImage.backgroundColor = .clear
        present(alert, animated: true)
    }
    
    private func updateCard(model: CardModel) {
        mainTitle.text = model.title
        priceTitle.text = model.price
        locationTitle.text = model.location
        createdDate.text = model.createdDate
        descriptionTitle.text = model.description
        emailTitle.text = model.email
        phoneTitle.text = model.phoneNumber
        addressTitle.text = model.address
        DispatchQueue.global().async {
            guard let url = URL(string: model.imageURL), let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                self.mainImage.image = UIImage(data: data)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainImage)
        contentView.addSubview(mainTitle)
        contentView.addSubview(priceTitle)
        contentView.addSubview(locationTitle)
        contentView.addSubview(createdDate)
        contentView.addSubview(descriptionTitle)
        contentView.addSubview(emailTitle)
        contentView.addSubview(phoneTitle)
        contentView.addSubview(addressTitle)
        contentView.addSubview(errorView)
        contentView.addSubview(activityIndicator)
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
            mainImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: contentView.frame.size.width/Offset.mainImageWidthAnchor),
            mainImage.heightAnchor.constraint(equalTo: mainImage.widthAnchor),
            
            priceTitle.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: Offset.titleTopAnchor),
            priceTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Offset.priceTitleLeadingAnchor),
            priceTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Offset.priceTitleTrailingAnchor),
            
            mainTitle.topAnchor.constraint(equalTo: priceTitle.bottomAnchor, constant: Offset.titleTopAnchor),
            mainTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            mainTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            
            locationTitle.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: Offset.titleTopAnchor),
            locationTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            locationTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            
            addressTitle.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: Offset.titleTopAnchor),
            addressTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            addressTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            
            phoneTitle.topAnchor.constraint(equalTo: addressTitle.bottomAnchor, constant: Offset.titleTopAnchor),
            phoneTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            phoneTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            
            emailTitle.topAnchor.constraint(equalTo: phoneTitle.bottomAnchor, constant: Offset.titleTopAnchor),
            emailTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            emailTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            
            descriptionTitle.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: Offset.titleTopAnchor),
            descriptionTitle.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            descriptionTitle.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            
            createdDate.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: Offset.titleTopAnchor),
            createdDate.leadingAnchor.constraint(equalTo: priceTitle.leadingAnchor),
            createdDate.trailingAnchor.constraint(equalTo: priceTitle.trailingAnchor),
            createdDate.heightAnchor.constraint(equalToConstant: Offset.createdDateHeightAnchor)
        ])
    }
}

extension CardViewController: CustomAlertViewDelegate {
    func getDataAgain() {
        startLoad()
    }
}

private extension CardViewController {
    enum Offset {
        static let titleTopAnchor: CGFloat = 15
        static let mainImageWidthAnchor: CGFloat = 2
        static let priceTitleLeadingAnchor: CGFloat = 10
        static let priceTitleTrailingAnchor: CGFloat = -10
        static let createdDateHeightAnchor: CGFloat = 20
    }
}
