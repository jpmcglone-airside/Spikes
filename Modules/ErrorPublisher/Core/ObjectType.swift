import Foundation

/// A protocol to make your structs and classes identifiable by id or createdAt date
public protocol ObjectType: Identifiable, Hashable {
  var id: UUID { get }
  var createdAt: Date { get }
}

/// Makes all ObjectTypes hashable
extension ObjectType {
  public func hash(into hasher: inout Hasher) {
    id.hash(into: &hasher)
  }
}
