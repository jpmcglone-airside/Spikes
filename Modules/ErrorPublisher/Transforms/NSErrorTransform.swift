import Foundation

/// Transforms an NSError to a PublishableError
public struct NSErrorTransform: TransformType {
  public typealias OldError = NSError

  public func transformToError(_ error: OldError) -> PublishableError {
    let error = PublishableError(
      ErrorKey("NSError"),
      description: error.localizedDescription,
      reason: error.localizedFailureReason,
      code: error.code,
      context: error.userInfo,
      original: error
    )

    return error
  }
}
