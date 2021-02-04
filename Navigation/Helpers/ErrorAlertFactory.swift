//
//  ErrorAlertFactory.swift
//  Navigation
//
//  Created by Egor Badaev on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ErrorAlertFactory {
    static func errorAlert(title: String, message: String) -> UIAlertController {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        return errorAlert
    }
    static func errorAlert(message: String) -> UIAlertController {
        return ErrorAlertFactory.errorAlert(title: "Ошибка", message: message)
    }
}
