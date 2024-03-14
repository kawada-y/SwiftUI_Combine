//
//  Session.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import Foundation

final class Session: ObservableObject {
    @Published var isLogin: Bool
    @Published var user: User?
    
    init(isLogin: Bool = false, user: User? = nil) {
        self.isLogin = isLogin
        self.user = user
    }
}
