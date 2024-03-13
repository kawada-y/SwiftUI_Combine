//
//  News.swift
//  SwiftUI_Combine
//
//  Created by 河田佳之 on 2024/03/14.
//

import Foundation
import Combine

class News {
    var info: String
    
    init(info: String) {
        self.info = info
    }
}

class NewsSubscriber: Subscriber {
    // NotificationCenter.Publisherと型をあわせる
    typealias Input = Notification
    // NotificationCenter.Publisherと型をあわせる
    typealias Failure = Never
    
    var publisher: NotificationCenter.Publisher
    var subscription: Subscription?
    
    init(notificationPublisher: NotificationCenter.Publisher) {
        // publisherを保持する
        self.publisher = notificationPublisher
        // publisherのsubscribeメソッドを呼ぶ
        self.publisher.subscribe(self)
    }
    
    // publisherがsubscriberを登録したときに呼ばれる
    func receive(subscription: Subscription) {
        print(subscription)
        self.subscription = subscription
        subscription.request(.unlimited)
    }
    
    // publisherから要素が送られてくる。配信個数を要求する
    func receive(_ input:Notification) -> Subscribers.Demand {
        let news = input.object as? News
        print(news?.info ?? "")
        // 配信個数に制限なし
        return .unlimited
    }
    
    // 配信が完了したときに呼ばれる
    func receive(completion: Subscribers.Completion<Never>) {
        print("completion")
    }
}

extension Notification.Name {
    static let News = Notification.Name("com.combine_introduce.news")
}
