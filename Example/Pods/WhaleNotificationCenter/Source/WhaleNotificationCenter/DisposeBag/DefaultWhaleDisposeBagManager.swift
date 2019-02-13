//
//  DefaultWhaleNotificationDisposeBagManager.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public final class DefaultWhaleNotificationDisposeBagManager: WhaleNotificationDisposeBagManager {
    public static var shared: DefaultWhaleNotificationDisposeBagManager = DefaultWhaleNotificationDisposeBagManager()

    private let serialQueue = DispatchQueue.init(label: "DefaultWhaleNotificationDisposeBagManagerSerialQueue")
    private var disposeBag = Array<WhaleNotificationRouter>()

    public init() { }

    public func addToDisposeBag(_ router: WhaleNotificationRouter) {
        serialQueue.async { [weak self] in
            self?.disposeBag.append(router)
        }
    }

    public func dispose() {
        serialQueue.async { [weak self] in
            self?.disposeBag.removeAll { handler in
                return !handler.isTargetAlive()
            }
        }
    }

    public func getAliveTargetCount() -> Int {
        return disposeBag.filter { $0.isTargetAlive() }.count
    }
}
