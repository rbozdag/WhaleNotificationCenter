# WhaleNotificationCenter
Fixed NSNotificationCenter Swift Api

## Installation

### Cocoapods

Install [Cocoapods](https://cocoapods.org/#install) if need be.

```bash
$ gem install cocoapods
```

Add `WhaleNotificationCenter` in your `Podfile`.

```ruby
use_frameworks!

pod 'WhaleNotificationCenter', :git => 'https://github.com/rbozdag/WhaleNotificationCenter.git'
```

## Usage

Firstly, import `WhaleNotificationCenter`.

```swift
import WhaleNotificationCenter
```

```swift
extension <yourClass or yourStruct or yourEnum>: WhaleNotifiable { }
```

### Example

Before conform 'WhaleNotifiable' protocol.
```swift
struct User: WhaleNotifiable {
    let name: String
}

enum LoginStatus: WhaleNotifiable {
    case login(User)
    case logout
}
```

Observe LoginStatus
```swift
LoginStatus.observe(target: self) { [weak self] loginStatus in
    switch loginStatus {
    case .login(let user):
        self?.label.text = "Login: " + user.name
    case .logout:
        self?.label.text = "Logout"
    }
}
```

finally broadcast
```swift
let user = User(name: "user_name")
LoginStatus.login(user).broadcast()
```

