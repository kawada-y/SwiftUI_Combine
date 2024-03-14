//
//  ContentView.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject var session: Session = Session()

    var body: some View {
        VStack {
            if self.session.isLogin {
                HomeView()
                    .environmentObject(self.session)
            } else {
                LoginView()
                    .environmentObject(self.session)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Session())
}
