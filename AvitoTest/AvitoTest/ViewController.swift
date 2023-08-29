//
//  ViewController.swift
//  AvitoTest
//
//  Created by Дмитрий on 27.08.2023.
//

import UIKit

class ViewController: UIViewController {
    private lazy var collectionView = UICollectionView(frame: self.view.bounds,
                                                       collectionViewLayout: UICollectionViewFlowLayout())
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = view.bounds
        activityIndicator.color = UIColor.gray
        return activityIndicator
    }()
    private lazy var errorView = CustomAlertView(frame: view.bounds)
    private var models: [Announcement] = []
    private let networkService: NetworkServiceProtocol
    private let alertFactory: AlertFactoryProtocol
    
    init(netwrokService: NetworkServiceProtocol, alertFactory: AlertFactoryProtocol) {
        self.networkService = netwrokService
        self.alertFactory = alertFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        title = "Объявления"
        errorView.delegate = self
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        setupViews()
        startLoad()
    }
    
    private func startLoad() {
        errorView.isHidden = true
        networkService.getData { [weak self] result in
            switch result {
            case .success(let ad):
                self?.models = ad.advertisements
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
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
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
    }
    
    private func showAlert() {
        let alert = alertFactory.makeAlert { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.startLoad()
        }
        present(alert, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        guard let cell = cell as? CustomCollectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(imageLoader: ImageLoader())
        cell.tap = { [weak self] id in
            guard let self else {
                return
            }
            self.navigationController?.pushViewController(CardViewController(id: id,
                                                                             netwrokService: self.networkService, alertFactory: alertFactory), animated: false)
        }
        cell.updateCell(model: models[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.size.width / 2 - 5, height: view.frame.size.width)
    }
}

extension ViewController: CustomAlertViewDelegate {
    func getDataAgain() {
        startLoad()
    }
}
