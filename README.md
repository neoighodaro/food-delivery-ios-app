# Food Delivery Application
A food delivery application built using Swift for iOS. The application uses Pushers notifications feature to send push notifications to mobile devices.

[View tutorial](https://pusher.com/tutorials/food-delivery-notifications-swift)

![](https://www.dropbox.com/s/fl0r5qjacnusb5l/Food-Delivery-App-with-Push-Notifications14.gif?raw=1)

## Requirements
- A Mac with Xcode installed.
- Knowledge of using Xcode.
- Knowledge of Swift.
- A Pusher account.
- Basic knowledge of JavaScript/Node.js.
- Cocoapods installed on your machine.

## Installation
* Download the repository.
* `cd` to both apps directory and run `pod install` in them both.
* Open both applications workspace file in Xcode.
* Set up your Pusher push notifications app (if you want to test push notifications).
* Copy `Backend/config.example.js` to `Backend/config.js` and enter your applications credentials.
* Run `node index.js` inside the `Backend` directory.
* Run the Xcode application(s).

> ⚠️ To test the Push notifications you will need to first use [Ngrok](http://ngrok.io) to tunnel your backend application, change the URL to the API in the `AppDelegate` of both projects, then run the applications on your iOS device. You also need a paid Apple Developer account.
