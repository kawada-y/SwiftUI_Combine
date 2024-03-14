//
//  AuthProvider.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import Foundation
import Combine

final class AuthProvider: AuthProviderProtocol {
    func login(userId: String, password: String) -> Future<User, Error> {
        
        return Future<User, Error> { promise in
            // This closure is unexpectedly called synchronously.
            // Therefore, wrap it with DispatchQueue.global().async
            DispatchQueue.global().async {
                // Intended to network communicate
                Thread.sleep(forTimeInterval: 1.0)
                
                 if userId == "user1@example.com" && password == "password" {
                     promise(.success(User(id: userId, name: "user1")))
                 } else {
                     promise(.failure(AuthError.invalidIdOrPassword))
                 }
            }
        }
    }
    
    func logout() -> Future<Void, Error> {
        // This closure is unexpectedly called synchronously.
        // Therefore, wrap it with DispatchQueue.global().async
        return Future<Void, Error> { promise in
            DispatchQueue.global().async {
                // Intended to network communicate
                Thread.sleep(forTimeInterval: 1.0)
                
                promise(.success(()))
            }
        }
    }
}
