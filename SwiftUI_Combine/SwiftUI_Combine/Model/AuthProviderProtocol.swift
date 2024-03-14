//
//  AuthProviderProtocol.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import Foundation
import Combine

enum AuthError: Error {
    case invalidIdOrPassword
}

protocol AuthProviderProtocol {
    func login(userId: String, password: String) -> Future<User, Error>
    func logout() -> Future<Void, Error>
}
