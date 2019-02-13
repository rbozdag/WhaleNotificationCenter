//
//  ViewController.swift
//  WhaleNotificationCenterExample
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import UIKit
import WhaleNotificationCenter

class ViewController: UIViewController {

    @IBOutlet weak var labelLoginInfo: UILabel!
    @IBOutlet weak var labelKeyboardStatus: UILabel!
    var counter = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        LoginStatus.observe(target: self) { [weak self] loginStatus in
            switch loginStatus {
            case .login(let user):
                self?.labelLoginInfo.text = "Login: " + user.name
            case .logout:
                self?.labelLoginInfo.text = "Logout"
            }
        }

        KeyboardNotifications.didChangeFrame.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard DidChangeFrame"
        }

        KeyboardNotifications.didHide.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard DidHide"
        }

        KeyboardNotifications.didShow.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard DidShow"
        }

        KeyboardNotifications.willChangeFrame.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard WillChangeFrame"
        }

        KeyboardNotifications.willHide.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard WillHide"
        }

        KeyboardNotifications.willShow.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard WillShow"
        }
        
        UIApplicationNotifications.didBecomeActive.observe(target: self) {
            print("UIApplicationNotifications", "didBecomeActive")
        }
        UIApplicationNotifications.didEnterBackground.observe(target: self) {
            print("UIApplicationNotifications", "didEnterBackground")
        }
        UIApplicationNotifications.willEnterForeground.observe(target: self) {
            print("UIApplicationNotifications", "willEnterForeground")
        }
        UIApplicationNotifications.willTerminate.observe(target: self) {
            print("UIApplicationNotifications", "willTerminate")
        }

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @IBAction func loginAction(_ sender: Any?) {
        let user = User(name: "Rahmi \(counter)")
        LoginStatus.login(user).broadcast()

        counter += 1
    }

    @IBAction func logoutAction(_ sender: Any?) {
        LoginStatus.logout.broadcast()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

struct User: WhaleNotifiable {
    let name: String
}

enum LoginStatus: WhaleNotifiable {
    case login(User)
    case logout
}
