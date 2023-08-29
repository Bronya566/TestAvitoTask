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
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Объявления" 
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        setupViews()
    }

    private func setupViews() {
        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        guard let cell = cell as? CustomCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.tap = { [weak self] image, title in
            self?.navigationController?.pushViewController(CardViewController(image: image, title: title), animated: false)
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.size.width / 2 - 10, height: view.frame.size.width)
    }
}
