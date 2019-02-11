//
//  WhaleNotificationCenterTests.swift
//  WhaleNotificationCenterTests
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import XCTest
@testable import WhaleNotificationCenter

class WhaleNotificationCenterTests: XCTestCase {

    func testNotification() {
        var notificationExpectation: XCTestExpectation? = expectation(description: "notificationExpectation")

        User.observe(target: self) { observedValue in
            notificationExpectation?.fulfill()
            notificationExpectation = nil
            XCTAssert(observedValue.name == "test_user")
        }

        let user = User(name: "test_user")
        user.broadcast()
        self.waitForExpectations(timeout: 1) { _ in }
    }

    func testTargetRetainCycle() {
        var notificationExpectation: XCTestExpectation? = expectation(description: "TargetRetainCycleExpectation")

        var dummyObserver: DummyObserver? = DummyObserver(name: "dummy_observer", deinitListener: {
            notificationExpectation?.fulfill()
            notificationExpectation = nil
        })

        User.observe(target: dummyObserver!) { _ in }

        dummyObserver = nil

        User(name: "test_user").broadcast()

        self.waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail("Observer target is not deallocated")
            }
        }
    }

    func testDisposeBagRetainCycle() {
        var notificationExpectation: XCTestExpectation? = expectation(description: "DisposeBagRetainCycleExpectation")

        let dummyDisposeBag = DummyDisposeBagManager()

        var dummyObserver: DummyObserver? = DummyObserver(name: "dummy_observer", deinitListener: {
            notificationExpectation?.fulfill()
            notificationExpectation = nil
        })

        User.observe(disposeBag: dummyDisposeBag, target: dummyObserver!) { _ in }
        dummyObserver = nil

        User(name: "test_user").broadcast()

        self.waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail("Observer target is not deallocated")
            } else {
                XCTAssert(dummyDisposeBag.disposeBag.count == 0, "disposeBag must be zero because there is no observer.")
            }
        }
    }
}
