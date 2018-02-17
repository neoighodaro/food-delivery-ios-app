import Foundation

extension Encodable {
    func encode() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
