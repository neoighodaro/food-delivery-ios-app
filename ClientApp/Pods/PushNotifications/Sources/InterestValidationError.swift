import Foundation

/**
 Error thrown by PushNotifications.

 *Values*

 `invalidName` The interest name is invalid.
 */
public enum InvalidInterestError: Error {
    /**
     Invalid interest name.

     - Parameter: interest
     */
    case invalidName(String)
}
