//
//  LoginViewModel.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    private let authProvider: AuthProviderProtocol
    
    @Published var userId: String = ""
    @Published var password: String = ""
    
    @Published private var isBusy: Bool = false
    @Published private(set) var canLogin: Bool = true
    @Published private(set) var validationText: String = ""
    
    func login() -> AnyPublisher<User, Error> {
        isBusy = true
        validationText = ""
        
        return authProvider.login(userId: userId, password: password)
            .receive(on: RunLoop.main)
            .handleEvents(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.validationText = ""
                case .failure:
                    self?.validationText = "User IDもしくは、 passwordが正しくありません"
                }
                
                self?.isBusy = false
            })
            .eraseToAnyPublisher()
    }
    
    init(authProvider: AuthProviderProtocol = AuthProvider()) {
        self.authProvider = authProvider
        
        _ = Publishers
            .CombineLatest3($userId, $password, $isBusy)
            .map { (userId, password, isBusy) in
                return !(userId.isEmpty || password.isEmpty || isBusy)
            }
            .receive(on: RunLoop.main)
            .assign(to: \.canLogin, on: self)
    }
}
