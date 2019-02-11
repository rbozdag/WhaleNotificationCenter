//
//  WhaleNotificationRouter.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public final class DefaultWhaleNotificationRouter: WhaleNotificationRouter {
    private let action: (Any?) -> ()
    public let isTargetAlive: () -> Bool

    public init<T>(disposeBag: WhaleNotificationDisposeBagManager, target: AnyObject, action: @escaping (T) -> ()) {
        self.action = { [weak target, weak disposeBag] observedValue in
            if target != nil, let observedValue = observedValue as? T {
                action(observedValue)
            } else {
                disposeBag?.dispose()
            }
        }

        self.isTargetAlive = { [weak target] in
            return target != nil
        }

        disposeBag.addToDisposeBag(self)
    }

    @objc public func onNotificationHandled(_ notification: Notification) {
        action(notification.object)
    }

    deinit { print("deinit WhaleNotificationRouter") }
}
