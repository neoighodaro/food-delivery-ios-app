import Foundation

struct Instance {
    private static let key = "com.pusher.sdk.instanceId"
    private static let userDefaults = UserDefaults(suiteName: "PushNotifications")!

    static func persist(_ instanceId: String) throws {
        guard let savedInstanceId = Instance.getInstanceId() else {
            self.userDefaults.set(instanceId, forKey: key)
            return
        }

        guard instanceId == savedInstanceId else {
            let errorMessage = """
            This device has already been registered with Pusher.
            Push Notifications application with instance id: \(savedInstanceId).
            If you would like to register this device to \(instanceId) please reinstall the application.
            """

            throw PusherAlreadyRegisteredError.instanceId(errorMessage)
        }
    }

    static func getInstanceId() -> String? {
        return self.userDefaults.string(forKey: key)
    }
}
