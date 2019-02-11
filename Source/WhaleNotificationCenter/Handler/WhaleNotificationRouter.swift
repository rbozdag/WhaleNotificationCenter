//
//  WhaleNotificationRouter.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public protocol WhaleNotificationRouter: class {
    var isTargetAlive: () -> Bool { get }
    func onNotificationHandled(_ notification: Notification)

    init<T>(disposeBag: WhaleNotificationDisposeBagManager, target: AnyObject, action: @escaping (T) -> ())
}
