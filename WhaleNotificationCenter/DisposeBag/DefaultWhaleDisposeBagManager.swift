//
//  DefaultWhaleNotificationDisposeBagManager.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public final class DefaultWhaleNotificationDisposeBagManager: WhaleNotificationDisposeBagManager {
    public static var shared: WhaleNotificationDisposeBagManager = DefaultWhaleNotificationDisposeBagManager()

    private let serialQueue = DispatchQueue.init(label: "DefaultWhaleNotificationDisposeBagManagerSerialQueue")
    private var disposeBag = Array<WhaleNotificationRouter>()

    public func addToDisposeBag(_ handler: WhaleNotificationRouter) {
        serialQueue.async { [weak self] in
            self?.disposeBag.append(handler)
        }
    }

    public func dispose() {
        serialQueue.async { [weak self] in
            self?.disposeBag.removeAll { handler in
                return !handler.isTargetAlive()
            }
        }
    }
}
