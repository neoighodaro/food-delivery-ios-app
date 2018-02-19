import Foundation

struct Track: Encodable {
    let publishId: String
    let timestampSecs: UInt
    let eventType: String
    let deviceId: String
}
