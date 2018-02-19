# PushNotifications iOS & macOS SDK

[![Build Status](https://www.bitrise.io/app/2798096bb06e322f/status.svg?token=GHiO2KcqAY_UDS8g8M-f5g&branch=master)](https://www.bitrise.io/app/2798096bb06e322f)
[![codecov](https://codecov.io/gh/pusher/push-notifications-swift/branch/master/graph/badge.svg)](https://codecov.io/gh/pusher/push-notifications-swift)
[![Documentation](https://pusher.github.io/push-notifications-swift/badge.svg)](https://pusher.github.io/push-notifications-swift/Classes/PushNotifications.html)
![](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/PushNotifications.svg)](https://cocoapods.org/pods/PushNotifications)
[![Carthage](https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Twitter](https://img.shields.io/badge/twitter-@Pusher-blue.svg?style=flat)](http://twitter.com/Pusher)

## Example Code

* [iOS with Swift](https://github.com/pusher/push-notifications-swift/blob/master/push-notifications-ios/push-notifications-ios/AppDelegate.swift)
* [iOS with Objective-C](https://github.com/pusher/push-notifications-swift/blob/master/push-notifications-objc/push-notifications-objc/AppDelegate.m)
* [macOS with Swift](https://github.com/pusher/push-notifications-swift/blob/master/push-notifications-mac/push-notifications-mac/AppDelegate.swift)
* [macOS with Objective-C](https://github.com/pusher/push-notifications-swift/blob/master/push-notifications-mac-objc/push-notifications-mac-objc/AppDelegate.m)

## Building and Running

### Minimum Requirements
* [Xcode](https://itunes.apple.com/us/app/xcode/id497799835) - The easiest way to get Xcode is from the [App Store](https://itunes.apple.com/us/app/xcode/id497799835?mt=12), but you can also download it from [developer.apple.com](https://developer.apple.com/) if you have an AppleID registered with an Apple Developer account.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods version 1.3.1 or newer is recommended to build PushNotifications.

To integrate PushNotifications into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

# Replace `<Your Target Name>` with your app's target name.
target '<Your Target Name>' do
    pod 'PushNotifications'
end
```

Then, run the following command:

```bash
$ pod install --repo-update
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

> Carthage version 0.26.2 or newer is recommended to build PushNotifications.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate PushNotifications into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "pusher/push-notifications-swift"
```

Run `carthage update` to build the framework and drag the built `PushNotifications.framework`into your Xcode project.

## PushNotifications Reference
* [shared](https://pusher.github.io/push-notifications-swift/Classes/PushNotifications.html) - [View in Source](x-source-tag://shared)
* [start(instanceId:)](https://pusher.github.io/push-notifications-swift/Classes/PushNotifications.html) - [View in Source](x-source-tag://start)
* [registerForRemoteNotifications](https://pusher.github.io/push-notifications-swift/Classes/PushNotifications.html) - [View in Source](x-source-tag://register)
* [registerForRemoteNotifications(options:)](https://pusher.github.io/push-notifications-swift/Classes/PushNotifications.html) - [View in Source](x-source-tag://registerOptions) 
* [registerDeviceToken(_:completion:)]() - [View in Source](x-source-tag://registerDeviceToken)
* [subscribe(interest:completion:)]() - [View in Source](x-source-tag://subscribe)
* [setSubscriptions(interests:completion:)]() - [View in Source](x-source-tag://setSubscriptions)
* [unsubscribe(interest:completion:)]() - [View in Source](x-source-tag://unsubscribe)
* [unsubscribeAll(completion:)]() - [View in Source](x-source-tag://unsubscribeAll)
* [getInterests()](https://pusher.github.io/push-notifications-swift/Classes/PushNotifications.html) - [View in Source](x-source-tag://getInterests)

## Communication

- Found a bug? Please open an [issue](https://github.com/pusher/push-notifications-swift/issues).
- Have a feature request. Please open an [issue](https://github.com/pusher/push-notifications-swift/issues).
- If you want to contribute, please submit a [pull request](https://github.com/pusher/push-notifications-swift/pulls) (preferrably with some tests).


## Credits

PushNotifications is owned and maintained by [Pusher](https://pusher.com).


## License

PushNotifications is released under the MIT license. See [LICENSE](https://github.com/pusher/push-notifications-swift/blob/master/LICENSE) for details.
