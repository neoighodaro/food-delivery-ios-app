import Foundation

/**
 Error thrown by PushNotifications.

 *Values*

 `invalidNames` The interest names are invalid.
 */
public enum MultipleInvalidInterestsError: Error {
    /**
     Invalid interest names.

     - Parameter: interests
     */
    case invalidNames(Array<String>)
}
