import Foundation

public protocol ErrorSubscriber {
  var id: UUID { get }

  /**
   * Receive a publishable error. This gets called when an error with the proper key(s)
   * is published by the publisher
   * - Parameters:
   *   - error: the received error
   */
  func receiveError(_ error: PublishableError)
}

extension ErrorSubscriber {
  /**
   * Subscribes to a specific publisher
   * - Parameters:
   *   - publisher: the publisher to subscribe to
   */
  public func subscribe(to publisher: ErrorPublisher) {
    publisher.subscribe(self)
  }
}
