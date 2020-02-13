import Foundation

public protocol TransformType {
  associatedtype OldError where OldError: Swift.Error

  /**
   * Transforms the OldError into a PublishableError
   * - Parameters:
   *   - error: the oldError
   */
  func transformToError(_ error: OldError) -> PublishableError
}
