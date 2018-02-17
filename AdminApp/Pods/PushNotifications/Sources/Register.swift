import Foundation

struct Register: Encodable {
    let token: String
    let instanceId: String
    let bundleIdentifier: String
    let metadata: Metadata
}

struct Metadata: Encodable {
    let sdkVersion: String
    let iosVersion: String?
    let macosVersion: String?
}
