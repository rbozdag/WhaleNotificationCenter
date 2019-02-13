//
//  ViewController.swift
//  WhaleNotificationCenterExample
//
//  Created by Rahmi Bozdağ on 11.02.2019.
//  Copyright © 2019 Rahmi Bozdag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var counter = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        LoginStatus.observe(target: self) { [weak self] loginStatus in
            switch loginStatus {
            case .login(let user):
                self?.label.text = "Login: " + user.name
            case .logout:
                self?.label.text = "Logout"
            }
        }

        KeyboardNotifications.DidChangeFrame.observe(target: self) { [weak self] data in
            self?.label.text = "Keyboard DidChangeFrame"
        }
        
        KeyboardNotifications.DidHide.observe(target: self) { [weak self] data in
            self?.label.text = "Keyboard DidHide"
        }
        
        KeyboardNotifications.DidShow.observe(target: self) { [weak self] data in
            self?.label.text = "Keyboard DidShow"
        }
        
        KeyboardNotifications.WillChangeFrame.observe(target: self) { [weak self] data in
            self?.label.text = "Keyboard WillChangeFrame"
        }
        
        KeyboardNotifications.WillHide.observe(target: self) { [weak self] data in
            self?.label.text = "Keyboard WillHide"
        }
        
        KeyboardNotifications.WillShow.observe(target: self) { [weak self] data in
            self?.label.text = "Keyboard WillShow"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            self?.view.endEditing(true)
        }
    }

    @IBAction func loginAction(_ sender: Any?) {
        let user = User(name: "Rahmi \(counter)")
        LoginStatus.login(user).broadcast()

        counter += 1
    }

    @IBAction func logoutAction(_ sender: Any?) {
        LoginStatus.logout.broadcast()
    }

}

struct User: WhaleNotifiable {
    let name: String
}

enum LoginStatus: WhaleNotifiable {
    case login(User)
    case logout
}
