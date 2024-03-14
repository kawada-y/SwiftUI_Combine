//
//  LoginView.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import SwiftUI

struct LoginView: View {
    // session
    @EnvironmentObject var session: Session
    // viewModel
    @ObservedObject private var loginVM = LoginViewModel()

    var body: some View {
        VStack {
            Text("Combineテストアプリ")
                .font(.title)

            TextField("User ID", text: $loginVM.userId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(UITextAutocapitalizationType.none)

            SecureField("Password", text: $loginVM.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if (!loginVM.validationText.isEmpty) {
                Text(loginVM.validationText)
                    .font(.caption)
                    .foregroundColor(Color.red)
            }

            Button {
                _ = self.loginVM.login()
                    .sink(receiveCompletion: { completion in
                        print("receiveCompletion:", completion)
                    }, receiveValue: { user in
                        print("userId:", user.id)
                        self.session.user = user
                        self.session.isLogin = true
                    })
            } label: {
                Text("ログイン")
            }
            .disabled(!loginVM.canLogin)
            
        }.padding()
    }
}

#Preview {
    LoginView()
        .environmentObject(Session())
}
