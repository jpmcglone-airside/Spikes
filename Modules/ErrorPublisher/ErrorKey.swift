import Foundation

/// PubishableErrors have an ErrorKey, which is used to route errors in Error Publisher
public struct ErrorKey: Equatable, Hashable {
  /// The default ErrorKey, .global
  public static let global = ErrorKey("global")

  /// The value of the error key
  public let value: String

  /**
   * Initializer
   * - Parameters:
   *   - value: the string value for the ErrorKey
   */
  public init(_ value: String) {
    self.value = value
  }
}

extension ErrorKey: ExpressibleByStringInterpolation {
  public init(stringLiteral value: String) {
    self.init(value)
  }}

extension ErrorKey: CustomStringConvertible {
  public var description: String {
    return value
  }
}
