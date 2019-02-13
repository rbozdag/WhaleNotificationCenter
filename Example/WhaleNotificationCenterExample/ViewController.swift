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

        KeyboardNotifications.DidChangeFrame.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard DidChangeFrame"
        }

        KeyboardNotifications.DidHide.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard DidHide"
        }

        KeyboardNotifications.DidShow.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard DidShow"
        }

        KeyboardNotifications.WillChangeFrame.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard WillChangeFrame"
        }

        KeyboardNotifications.WillHide.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard WillHide"
        }

        KeyboardNotifications.WillShow.observe(target: self) { [weak self] data in
            self?.labelKeyboardStatus.text = "Keyboard WillShow"
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
