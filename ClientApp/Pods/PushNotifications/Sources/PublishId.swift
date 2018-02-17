import Foundation

struct PublishId {
    let id: String?

    init(userInfo: [AnyHashable: Any]) {
        let data = userInfo["data"] as? Dictionary<String, Any>
        let pusher = data?["pusher"] as? Dictionary<String, Any>
        self.id = pusher?["publishId"] as? String
    }
}
