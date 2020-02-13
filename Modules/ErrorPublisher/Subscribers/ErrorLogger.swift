import Foundation

/// A simple Error Logger that also remembers every error it receives
public class ErrorLogger: Object, ErrorSubscriber {
  /// A log of all of the errors this ErrorLogger has received
  public var errors = [PublishableError]()

  public func receiveError(_ error: PublishableError) {
    errors.append(error)
    let out = """
              ==============
              ErrorLogger received error:
              \(formattedDate(Date()))

              - key:          \(error.key)
              - createdAt:    \(formattedDate(error.createdAt))
              - description:  \(error.description ?? "N/A")
              - reason:       \(error.reason ?? "N/A")
              - context:      \(error.context)
              ==============
              """
    print(out)
  }

  public override init() { }

  private func formattedDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss a zzz"
    return dateFormatter.string(from: date)
  }
}
