import Foundation

/// ErrorPublisher allows you to subscribe to and publish errors
public class ErrorPublisher {
  /// The shared publisher
  public static let shared = ErrorPublisher()

  /// A map for keys to subscribers. Only used if this subscriber is setup with specific keys
  private var keySubscribers = [ErrorKey: [ErrorSubscriber]]()

  /// A map for global subscribers. Only used if this subscriber is not setup with specific keys
  private var globalSubscribers = [ErrorSubscriber]()

  /// The initializer
  public init() { }

  /// The version of this module
  public static var version: String {
    let bundle = Bundle(for: ErrorPublisher.self)
    let version = bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    return version ?? "N/A"
  }

  // MARK: - Publish

  /**
   * Publish an error
   * - Parameters:
   *   - error: the error to publish
   */
  public func publish(_ error: PublishableError) {
    let subscribers = self.keySubscribers[error.key] ?? []
    subscribers.forEach {
      $0.receiveError(error)
    }

    globalSubscribers.forEach {
      $0.receiveError(error)
    }
  }

  // MARK: - Subscribe

  /**
   * Register a subscriber to this publisher for various keys
   * - Parameters:
   *   - subscriber: the subscriber for this publisher
   *   - keys: the error keys to subscribe to
   */
  public func subscribe(_ subscriber: ErrorSubscriber, forKeys keys: [ErrorKey]) {
    keys.forEach {
      self.subscribe(subscriber, forKey: $0)
    }

    // Cleanup
    unsubscribeFromGlobal(subscriber)
  }

  /**
   * Register a subscriber to this publisher for one key
   * - Parameters:
   *   - subscriber: the subscriber for this publisher
   *   - key: the singular key to subscribe to
   */
  public func subscribe(_ subscriber: ErrorSubscriber, forKey key: ErrorKey) {
    if let _ = keySubscribers[key] {
      keySubscribers[key]?.append(subscriber)
    } else {
      keySubscribers[key] = [subscriber]
    }

    self.subscribe(subscriber, forKeys: [])
  }

  /**
   * Register a subscriber to this publisher for all keys
   * - Parameters:
   *   - subscriber: the subscriber for this publisher
   */
  public func subscribe(_ subscriber: ErrorSubscriber) {
    globalSubscribers.append(subscriber)
    // Remove from keys
  }

  // MARK: - Unsubscribe

  /**
   * Remove a specific subscriber from receiving errors on a set of keys, or all keys
   * - Parameters:
   *   - subscriber: the subscriber for this publisher
   *   - keys: the error keys to unsubscribe from
   */
  public func unsubscribe(_ subscriber: ErrorSubscriber, forKeys keys: [ErrorKey]) {
    keys.forEach {
      self.unsubscribe(subscriber, forKey: $0)
    }
  }

  /**
   * Remove a specific subscriber from receiving errors on a specific error key
   * - Parameters:
   *   - subscriber: the subscriber for this publisher
   *   - keys: the singular error key to unsubscribe from
   */
  public func unsubscribe(_ subscriber: ErrorSubscriber, forKey key: ErrorKey) {
    if var subscribers = keySubscribers[key] {
      subscribers.removeAll { $0.id == subscriber.id }
      keySubscribers[key] = subscribers
    }
  }

  /**
   * Remove a specific subscriber from all keys
   * - Parameters:
   *   - subscriber: the subscriber for this publisher
   */
  public func unsubscribe(_ subscriber: ErrorSubscriber) {
    unsubscribeFromKeys(subscriber)
    unsubscribeFromGlobal(subscriber)
  }

  // MARK: - Private

  /**
   * Remove a specific subscriber from a set of keys, from only the key subscribers set
   * - Parameters:
   *   - subscriber: the subscriber for this publisher
   *   - keys: the error keys to unsubscribe from
   */
  private func unsubscribeFromKeys(_ subscriber: ErrorSubscriber) {
    for (key, var subscribers) in keySubscribers {
      subscribers.removeAll { $0.id == subscriber.id }
      keySubscribers[key] = subscribers
    }
  }

  /**
   * Remove a specific subscriber from the global Subscribers set
   * - Parameters:
   *   - subscriber: the subscriber for this publisher
   */
  private func unsubscribeFromGlobal(_ subscriber: ErrorSubscriber) {
    globalSubscribers.removeAll { $0.id == subscriber.id }
  }
}
