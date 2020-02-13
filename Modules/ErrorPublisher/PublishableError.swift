import Foundation

public struct PublishableError: Swift.Error, ObjectType {
  /// The unique id of the error. This is primarily used for caching
  public let id = UUID()

  /// When this particular error was created
  public var createdAt = Date()

  /// The key for the error. This is used by ErrorSubscriber and ErrorPublisher to route errors
  public let key: ErrorKey

  /// Describe the error, optional
  public let description: String?

  /// Describe the reason the error occured, optional
  public let reason: String?

  /// An error code, if applicable. Default is 0
  public let code: Int

  /// Add any additional context to the error that you'd like to add
  public var context: [String: Any]

  /// The original error (usually set through a Transform)
  public let original: Swift.Error?

  /**
   * The default initializer
   * - Parameters:
   *   - key: the error key used by ErrorSubscriber and ErrorPublisher to route errors
   *   - description: describes the error
   *   - reason: the reason for the error
   *   - code: the code associated with this error. 0 by default
   *   - context: additional information to attach with this error
   */
  public init(_ key: ErrorKey, description: String? = nil, reason: String? = nil, code: Int = 0, context: [String: Any] = [:], original: Swift.Error? = nil) {
    self.key = key
    self.description = description
    self.reason = reason
    self.code = code
    self.context = context
    self.original = original
  }

  /**
   * Publishes this error to a specified publisher
   * - Parameters:
   *   - publisher: the publisher to publish to
   */
  public func publish(to publisher: ErrorPublisher) {
    publisher.publish(self)
  }

  public static func == (lhs: PublishableError, rhs: PublishableError) -> Bool {
    return lhs.key == rhs.key
  }
}
