//
//  HomeViewModel.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject  {
    
    private let authProvider: AuthProviderProtocol
    
    @Published private(set) var canLogin: Bool = true
    
    func logout() -> AnyPublisher<Void, Error> {
        canLogin = false
        
        return authProvider.logout()
            .receive(on: RunLoop.main)
            .handleEvents(receiveCompletion: { [weak self] completion in
                self?.canLogin = true
            })
            .eraseToAnyPublisher()
    }
    
    init(authProvider: AuthProviderProtocol = AuthProvider()) {
        self.authProvider = authProvider
    }
}
