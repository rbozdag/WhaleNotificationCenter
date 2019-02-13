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
        self.waitForExpectations(timeout: 4) { _ in }
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
            } else {
                XCTAssert(DefaultWhaleNotificationDisposeBagManager.shared.getAliveTargetCount() == 0, "disposeBag must be zero because there is no observer.")
            }
        }
    }

    func testKeyboardNotification() {
        var notificationExpectation: XCTestExpectation? = expectation(description: "testKeyboardNotificationExpectation")

        XCTAssertTrue(KeyboardNotifications.didChangeFrame.notificationName == UIResponder.keyboardDidChangeFrameNotification)
        XCTAssertTrue(KeyboardNotifications.didHide.notificationName == UIResponder.keyboardDidHideNotification)
        XCTAssertTrue(KeyboardNotifications.didShow.notificationName == UIResponder.keyboardDidShowNotification)
        XCTAssertTrue(KeyboardNotifications.willChangeFrame.notificationName == UIResponder.keyboardWillChangeFrameNotification)
        XCTAssertTrue(KeyboardNotifications.willHide.notificationName == UIResponder.keyboardWillHideNotification)
        XCTAssertTrue(KeyboardNotifications.willShow.notificationName == UIResponder.keyboardWillShowNotification)
        
        KeyboardNotifications.willShow.observe(target: self) { data in
            notificationExpectation?.fulfill()
            notificationExpectation = nil
        }

        KeyboardNotifications.willShow().broadcast()
        
        self.waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail("KeyboardNotifications.WillShow not handled")
            }
        }
        
    }
    
    func testUIApplicationNotification() {
        var notificationExpectation: XCTestExpectation? = expectation(description: "testUIApplicationNotificationExpectation")
        
        UIApplicationNotifications.didBecomeActive.observe(target: self) {
            notificationExpectation?.fulfill()
            notificationExpectation = nil
        }
        
        UIApplicationNotifications.didBecomeActive().broadcast()
        
        self.waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail(" UIApplicationNotifications.didBecomeActivenot handled")
            }
        }
    }
}
