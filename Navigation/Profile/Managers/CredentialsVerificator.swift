//
//  CredentialsVerificator.swift
//  Navigation
//
//  Created by Egor Badaev on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class CredentialsVerificator: LoginViewControllerDelegate {
    
    private var login: String?
    private var password: String?
    
    /**
     Stores provided login for subsequent verification
     
     - parameters:
        - loginController: a source controller which provides data
        - login: login provided for verifications
     
     */
    func loginController(_ loginController: LogInViewController, didSubmitLogin login: String) {
        self.login = login
    }
    
    /**
     Stores provided password for subsequent verification
     
     - parameters:
        - loginController: a source controller which provides data
        - password: password provided for verifications
     
     */
    func loginController(_ loginController: LogInViewController, didSubmitPassword password: String) {
        self.password = password
    }
    
    /**
     Verifies credentials stored previously
     
     - returns: `true` if both stored credentials are correct, `false` otherwise
     
     - parameters:
        - loginController: a source controller which provides data
     
     - important: This function will issue an alert to user if there is an error.
     
     */
    func loginControllerShouldAllowLogin(_ loginController: LogInViewController) -> Bool {
        guard let login = self.login,
              !login.isEmpty else {
            loginController.presentErrorAlert(withMessage: "Логин не может быть пустым")
            return false
        }
        guard let password = self.password,
              !password.isEmpty else {
            loginController.presentErrorAlert(withMessage: "Пароль не может быть пустым")
            return false
        }

        if (!CredentialsStore.shared.credentialsAreCorrect(withLogin: login, andPassword: password)) {
            loginController.presentErrorAlert(withMessage: "Указанная комбинация логина и пароля не найдена")
            return false
        }
        
        return true
    }
}
