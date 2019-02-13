//
//  WhaleNotifiable.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public protocol WhaleNotifiable {
    associatedtype ObservedValueType

    static func decode(notification: Notification) -> ObservedValueType?

    static var notificationName: NSNotification.Name { get }

    static func observe(target: AnyObject, handler: @escaping (ObservedValueType) -> ())

    func broadcast()
}
