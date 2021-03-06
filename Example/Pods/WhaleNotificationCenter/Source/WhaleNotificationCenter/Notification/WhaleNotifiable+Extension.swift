//
//  WhaleNotifiable+Extension.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public extension WhaleNotifiable {
    public static var notificationName: NSNotification.Name {
        let typeof = String(describing: type(of: self))
        let description = String(describing: self).split(separator: "(").first!

        return NSNotification.Name(rawValue: "autogenerated_SafeNotification_\(typeof)_\(description)")
    }

    public var userInfo: [String: Any]? { return nil }

    public func broadcast() {
        NotificationCenter.default.post(name: Self.notificationName, object: self, userInfo: userInfo)
    }

    public static func observe(target: AnyObject, handler: @escaping (ObservedValueType) -> ()) {
        let router = DefaultWhaleNotificationRouter(disposeBag: DefaultWhaleNotificationDisposeBagManager.shared, target: target, decoder: decode, actionWithPrm: handler, actionWithoutPrm: nil)
        NotificationCenter.default.addObserver(router, selector: Selector(("onNotificationHandled:")), name: notificationName, object: nil)
    }

    public static func observe(target: AnyObject, handler: @escaping () -> ()) {
        let router = DefaultWhaleNotificationRouter(disposeBag: DefaultWhaleNotificationDisposeBagManager.shared, target: target, decoder: decode, actionWithPrm: nil, actionWithoutPrm: handler)
        NotificationCenter.default.addObserver(router, selector: Selector(("onNotificationHandled:")), name: notificationName, object: nil)
    }

    static func decode(notification: Notification) -> ObservedValueType? {
        return notification.object as? ObservedValueType
    }
}

public extension WhaleNotifiable where Self == ObservedValueType {
    public static func observe(target: AnyObject, handler: @escaping (Self) -> ()) {
        let router = DefaultWhaleNotificationRouter(disposeBag: DefaultWhaleNotificationDisposeBagManager.shared, target: target, decoder: decode, actionWithPrm: handler, actionWithoutPrm: nil)
        NotificationCenter.default.addObserver(router, selector: Selector(("onNotificationHandled:")), name: notificationName, object: nil)
    }
}
