//
//  WhaleNotifiable+Extension.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public extension WhaleNotifiable {
    public typealias ObservedValueType = Self

    public var userInfo: [String: Any]? { return nil }

    public static var notificationName: NSNotification.Name {
        let typeof = String(describing: type(of: self))
        let description = String(describing: self).split(separator: "(").first!

        return NSNotification.Name(rawValue: "autogenerated_SafeNotification_\(typeof)_\(description)")
    }

    public func broadcast() {
        NotificationCenter.default.post(name: Self.notificationName, object: self, userInfo: userInfo)
    }

    public static func observe(disposeBag: WhaleNotificationDisposeBagManager = DefaultWhaleNotificationDisposeBagManager.shared, router: WhaleNotificationRouter.Type = DefaultWhaleNotificationRouter.self, target: AnyObject, handler: @escaping (ObservedValueType) -> ()) {
        let handler = router.init(disposeBag: disposeBag, target: target, action: handler)
        NotificationCenter.default.addObserver(handler, selector: Selector(("onNotificationHandled:")), name: Self.notificationName, object: nil)
    }
}