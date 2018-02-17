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
    static let APIURL = "https://127.0.0.1:4000"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let pushNotifications = PushNotifications.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.pushNotifications.register(instanceId: "PUSHER_PUSH_NOTIF_INSTANCE_ID")
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.pushNotifications.registerDeviceToken(deviceToken) {
            try? self.pushNotifications.subscribe(interest: "orders_clientID")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
    }
}

