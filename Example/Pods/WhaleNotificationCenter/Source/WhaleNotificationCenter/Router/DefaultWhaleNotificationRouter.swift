//
//  WhaleNotificationRouter.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public final class DefaultWhaleNotificationRouter: WhaleNotificationRouter {
    private let action: (Notification) -> ()
    public let isTargetAlive: () -> Bool

    public init<T>(disposeBag: WhaleNotificationDisposeBagManager, target: AnyObject, decoder: @escaping (Notification) -> T?, actionWithPrm: ((T) -> ())?, actionWithoutPrm: (() -> ())?) {
        self.action = { [weak target, weak disposeBag] notification in
            if target != nil {
                if let actionWithPrm = actionWithPrm, let observedValue = decoder(notification) {
                    actionWithPrm(observedValue)
                } else if let actionWithoutPrm = actionWithoutPrm {
                    actionWithoutPrm()
                }
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
        action(notification)
    }

    deinit { print("deinit WhaleNotificationRouter") }
}
