import Foundation

struct Track: Encodable {
    let publishId: String
    let timestampMs: Int64
    let eventType: String
    let deviceId: String
}
