//
//  CustomAlertView.swift
//  AvitoTest
//
//  Created by Дмитрий on 29.08.2023.
//

import UIKit

protocol CustomAlertViewDelegate: AnyObject {
    func getDataAgain()
}

final class CustomAlertView: UIView {
    
    weak var delegate: CustomAlertViewDelegate?
    
    private let alertLabel = {
        let alert = UILabel()
        alert.text = Text.alertLabel
        alert.font = .boldSystemFont(ofSize: 25)
        return alert
    }()
    
    private let alertButton = {
        let alert = UIButton()
        alert.setTitle(Text.alertButton, for: .normal)
        alert.setTitleColor(ColorConstants.errorButtonTextColor, for: .normal)
        return alert
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        alertButton.addTarget(self, action: #selector(tapButtonAgain), for: .touchDown)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapButtonAgain() {
        delegate?.getDataAgain()
    }
    
    private func setupUI() {
        addSubview(alertLabel)
        addSubview(alertButton)
    }
    
    private func setupConstraints() {
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            alertButton.topAnchor.constraint(equalTo: alertLabel.bottomAnchor, constant: Offset.alertButtonTopAnchor),
            alertButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Offset.alertButtonLeadingAnchor),
            alertButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Offset.alertButtonTrailingAnchor)
        ])
    }
}

private extension CustomAlertView {
    enum Offset {
        static let alertButtonTopAnchor: CGFloat = 10
        static let alertButtonLeadingAnchor: CGFloat = 10
        static let alertButtonTrailingAnchor: CGFloat = -10
    }
    
    enum Text {
        static let alertLabel: String = "Данные не загрузились"
        static let alertButton: String = "Попробовать еще раз"
    }
}
