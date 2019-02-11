//
//  User.swift
//  WhaleNotificationCenterTests
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation

struct User: WhaleNotifiable {
    let name: String
}

class DummyObserver {
    let name: String

    let deinitListener: () -> ()

    init(name: String, deinitListener: @escaping () -> ()) {
        self.name = name
        self.deinitListener = deinitListener
    }
    
    deinit {
        deinitListener()
        print("deinit DummyObserver")
    }
}


class DummyDisposeBagManager: WhaleNotificationDisposeBagManager {
    let serialQueue = DispatchQueue.init(label: "DummyWhaleDisposeBagManagerSerialQueue")
    var disposeBag = Array<WhaleNotificationRouter>()

    public func addToDisposeBag(_ handler: WhaleNotificationRouter) {
        serialQueue.sync { [weak self] in
            self?.disposeBag.append(handler)
        }
    }

    public func dispose() {
        serialQueue.sync { [weak self] in
            self?.disposeBag.removeAll { handler in
                return !handler.isTargetAlive()
            }
        }
    }
    
    deinit { print("deinit DummyDisposeBagManager") }
}
