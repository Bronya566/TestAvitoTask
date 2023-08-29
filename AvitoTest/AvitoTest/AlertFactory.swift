//
//  AlertFactory.swift
//  AvitoTest
//
//  Created by Дмитрий on 29.08.2023.
//

import UIKit

protocol AlertFactoryProtocol {
    func makeAlert(tap: @escaping () -> Void) -> UIAlertController 
}

final class AlertFactory: AlertFactoryProtocol {
    
    func makeAlert(tap: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Извините", message: "Не удалось получить данные. Попробуйте позже", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default))
        alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
            tap()
        }))
        return alert
    }
}
