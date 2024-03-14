//
//  HomeView.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import SwiftUI

struct HomeView: View {
    // session
    @EnvironmentObject var session: Session
    // viewModel
    @ObservedObject private var homeVM = HomeViewModel()
    
    var body: some View {
        VStack {
            Text("Hello \(self.session.user?.name ?? "")!")
            Button {
                _ = self.homeVM.logout()
                    .sink(receiveCompletion: { err in
                        self.session.user = nil
                        self.session.isLogin = false
                    }, receiveValue: {})
            } label: {
                Text("Logout")
            }.disabled(!homeVM.canLogin)
        }
    }
}

#Preview {
    HomeView()
                .environmentObject(Session(isLogin: true, user: User(id: "userId", name: "foobar")))
}
