import Foundation

struct NetworkService: PushNotificationsNetworkable {

    let url: URL
    let session: URLSession

    typealias NetworkCompletionHandler = (_ response: NetworkResponse) -> Void

    // MARK: PushNotificationsRegisterable
    func register(deviceToken: Data, instanceId: String, completion: @escaping (String) -> Void) {
        let deviceTokenString = deviceToken.hexadecimalRepresentation()
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? ""

        let systemVersion = SystemVersion.version
        let sdkVersion = SDK.version

        #if os(iOS)
        let metadata = Metadata(sdkVersion: sdkVersion, iosVersion: systemVersion, macosVersion: nil)
        #elseif os(OSX)
        let metadata = Metadata(sdkVersion: sdkVersion, iosVersion: nil, macosVersion: systemVersion)
        #endif

        guard let body = try? Register(token: deviceTokenString, instanceId: instanceId, bundleIdentifier: bundleIdentifier, metadata: metadata).encode() else { return }
        let request = self.setRequest(url: self.url, httpMethod: .POST, body: body)

        self.networkRequest(request, session: self.session) { (response) in
            switch response {
            case .Success(let data):
                guard let device = try? JSONDecoder().decode(Device.self, from: data) else { return }
                completion(device.id)
            case .Failure(let data):
                print(data)
            }
        }
    }

    // MARK: PushNotificationsSubscribable
    func subscribe(completion: @escaping () -> Void = {}) {
        let request = self.setRequest(url: self.url, httpMethod: .POST)

        self.networkRequest(request, session: self.session) { (response) in
            completion()
        }
    }

    func setSubscriptions(interests: Array<String>, completion: @escaping () -> Void = {}) {
        guard let body = try? Interests(interests: interests).encode() else { return }
        let request = self.setRequest(url: self.url, httpMethod: .PUT, body: body)

        self.networkRequest(request, session: self.session) { (response) in
            completion()
        }
    }

    func unsubscribe(completion: @escaping () -> Void = {}) {
        let request = self.setRequest(url: self.url, httpMethod: .DELETE)

        self.networkRequest(request, session: self.session) { (response) in
            completion()
        }
    }

    func unsubscribeAll(completion: @escaping () -> Void = {}) {
        self.setSubscriptions(interests: [])
    }

    func track(userInfo: [AnyHashable: Any], eventType: String, deviceId: String) {
        guard let publishId = PublishId(userInfo: userInfo).id else { return }
        let timestampSecs = UInt(Date().timeIntervalSince1970)
        guard let body = try? Track(publishId: publishId, timestampSecs: timestampSecs, eventType: eventType, deviceId: deviceId).encode() else { return }

        let request = self.setRequest(url: self.url, httpMethod: .POST, body: body)
        self.networkRequest(request, session: self.session) { (response) in }
    }

    // MARK: Networking Layer
    private func networkRequest(_ request: URLRequest, session: URLSession, completion: @escaping NetworkCompletionHandler) {
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200, error == nil
            else {
                guard let reason = try? JSONDecoder().decode(Reason.self, from: data) else { return }
                return completion(NetworkResponse.Failure(description: reason.description))
            }

            completion(NetworkResponse.Success(data: data))

        }).resume()
    }

    private func setRequest(url: URL, httpMethod: HTTPMethod, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body

        return request
    }
}
