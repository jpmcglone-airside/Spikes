import Foundation

/// An Object class that has an id and a createdAt value, for easy indexing
public class Object: ObjectType {
  public let id = UUID()
  public let createdAt = Date()

  public static func == (lhs: Object, rhs: Object) -> Bool {
    return lhs.id == rhs.id
  }
}
