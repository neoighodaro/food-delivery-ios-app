import Foundation

extension Date {
    func milliseconds() -> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000) // Time in milliseconds.
    }
}
