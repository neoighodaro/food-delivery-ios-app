import Foundation

protocol InterestPersistable {
    func persist(interest: String) -> Bool
    func persist(interests: Array<String>)
    func remove(interest: String) -> Bool
    func removeAll()
    func getSubscriptions() -> Array<String>?
}
