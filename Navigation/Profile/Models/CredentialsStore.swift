//
//  CredentialsStore.swift
//  Navigation
//
//  Created by Egor Badaev on 02.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

struct CredentialsStore {
    
    private let login: String = "some@test.ru"
    private let password: String = "somepass"
    
    static let shared: CredentialsStore = {
        let instance = CredentialsStore()

        return instance
    }()
    
    /**
     Verifies provided credentials
     
     - parameters:
        - login: login provided by user
        - password: password provided by user
     
     - returns: `true` if all provided credentials are correct, `false` otherwise
     
     - Important:
     Credentials are deliberately not verified separately (e.g. to provide detailed info like "Login incorrect") for better security.
     */
    func credentialsAreCorrect(withLogin login: String, andPassword password: String) -> Bool {
        return (login == self.login) && (password == self.password)
    }
    
}
