import Foundation

/**
 Error thrown by PushNotifications.

 *Values*

 `instanceId` The instance id was already registered.
 */
public enum PusherAlreadyRegisteredError: Error {
    /**
     Instance id was already registered with Pusher.

     - Parameter: instanceId
     */
    case instanceId(String)
}
