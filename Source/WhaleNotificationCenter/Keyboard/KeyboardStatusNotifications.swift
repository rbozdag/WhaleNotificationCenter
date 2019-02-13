//
//  KeyboardStatusNotifications.swift
//  WhaleNotificationCenter
//
//  Created by Rahmi Bozdağ on 13.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import Foundation
import UIKit

struct KeyboardNotifications {

    public class KeyboardNotification {
        let animationCurveUserInfoKey: Int?
        let animationDurationUserInfoKey: Float?
        let frameBeginUserInfoKey: CGRect?
        let frameEndUserInfoKey: CGRect?
        let isLocalUserInfoKey: Int?

        init(animationCurveUserInfoKey: Int? = nil, animationDurationUserInfoKey: Float? = nil, frameBeginUserInfoKey: CGRect? = nil, frameEndUserInfoKey: CGRect? = nil, isLocalUserInfoKey: Int? = nil) {
            self.animationCurveUserInfoKey = animationCurveUserInfoKey
            self.animationDurationUserInfoKey = animationDurationUserInfoKey
            self.frameBeginUserInfoKey = frameBeginUserInfoKey
            self.frameEndUserInfoKey = frameEndUserInfoKey
            self.isLocalUserInfoKey = isLocalUserInfoKey
        }
    }

    public class WillShow: KeyboardNotification, WhaleNotifiable {
        typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardWillShowNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class DidShow: KeyboardNotification, WhaleNotifiable {
        typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardDidShowNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class WillHide: KeyboardNotification, WhaleNotifiable {
        typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardWillHideNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class DidHide: KeyboardNotification, WhaleNotifiable {
        typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardDidHideNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class DidChangeFrame: KeyboardNotification, WhaleNotifiable {
        typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardDidChangeFrameNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    public class WillChangeFrame: KeyboardNotification, WhaleNotifiable {
        typealias ObservedValueType = KeyboardNotification

        public static var notificationName: NSNotification.Name = UIResponder.keyboardWillChangeFrameNotification

        public static func decode(notification: Notification) -> KeyboardNotification? {
            return KeyboardNotifications.notificationToKeyboardDecoder(notification)
        }
    }

    fileprivate static func notificationToKeyboardDecoder(_ notification: Notification) -> KeyboardNotification {
        guard let userInfo = notification.userInfo else {
            return KeyboardNotification()
        }

        let keyboardData = KeyboardNotification(animationCurveUserInfoKey: (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
                                                animationDurationUserInfoKey: (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.floatValue,
                                                frameBeginUserInfoKey: (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
                                                frameEndUserInfoKey: (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                                                isLocalUserInfoKey: (userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? NSNumber)?.intValue
        )

        return keyboardData
    }
}
