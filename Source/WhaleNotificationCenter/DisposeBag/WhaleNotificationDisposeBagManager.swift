//
//  WhaleNotificationDisposeBagManager.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

public protocol WhaleNotificationDisposeBagManager: class {
    func addToDisposeBag(_ router: WhaleNotificationRouter)
    func dispose()
}
