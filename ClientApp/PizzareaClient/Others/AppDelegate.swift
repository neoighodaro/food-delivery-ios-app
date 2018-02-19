//
//  AppDelegate.swift
//  pizzarea
//
//  Created by Neo Ighodaro on 06/02/2018.
//  Copyright © 2018 CreativityKills Co. All rights reserved.
//

import UIKit
import CoreData
import PushNotifications

class AppConstants {
    static let APIURL = "http://127.0.0.1:4000"
    static let USER_ID = NSUUID().uuidString
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let pushNotifications = PushNotifications.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.pushNotifications.start(instanceId: "PUSHER_NOTIF_INSTANCE_ID")
        self.pushNotifications.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.pushNotifications.registerDeviceToken(deviceToken) {
            try? self.pushNotifications.subscribe(interest: "orders_" + AppConstants.USER_ID)
        }
    }
}

