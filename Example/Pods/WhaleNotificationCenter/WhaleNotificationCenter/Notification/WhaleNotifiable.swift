//
//  WhaleNotifiable.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public protocol WhaleNotifiable {
    associatedtype ObservedType

    static var notificationName: NSNotification.Name { get }

    static func observe(disposeBag: WhaleNotificationDisposeBagManager, router: WhaleNotificationRouter.Type, target: AnyObject, handler: @escaping (ObservedType) -> ())

    func broadcast()
}
