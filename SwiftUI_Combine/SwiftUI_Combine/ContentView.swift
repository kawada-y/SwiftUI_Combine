//
//  ContentView.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, combine")
            Button {
                do {
                    let notificationPublisher = NotificationCenter.Publisher(center: .default,
                                                                             name: .News,
                                                                             object: nil)
                    
                    let _ = NewsSubscriber(notificationPublisher: notificationPublisher)
                    
                    notificationPublisher
                        .center
                        .post(name: .News, object: News(info: "you got an item of news!"))
                }
            } label: {
                Text("push")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
