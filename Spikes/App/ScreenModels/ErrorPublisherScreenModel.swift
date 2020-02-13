import ErrorPublisher
import SwiftUI

class ErrorPublisherScreenModel: ObservableObject, ErrorSubscriber {
  let id = UUID()
  let errorPublisher: ErrorPublisher

  var count = 0

  @Published var alertError: PublishableError?
  @Published var latestError: PublishableError?

  @Published var asyncLoadingTime: Double = 1
  @Published var isLoadingAsync = false
  @Published var asyncError: PublishableError?

  // For putting the async error back
  var timer: Timer?

  private let asyncTimeTotal = 3
  @Published var timeRemaining = 0

  init(errorPublisher: ErrorPublisher) {
    self.errorPublisher = errorPublisher
    errorPublisher.subscribe(self)
  }

  deinit {
    errorPublisher.unsubscribe(self)
  }

  func receiveError(_ error: PublishableError) {
    latestError = error

    switch error.key {
    case .alertButton:
      if alertError == nil {
        alertError = error
      }
      // TODO: add error to a queue
    case .asyncError:
      asyncError = error
      timeRemaining = asyncTimeTotal
      let dT = 1
      // This can be simplified for sure; abstracted out SEE: FlowDK/Timer
      timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(dT), repeats: true, block: { timer in
        self.timeRemaining -= dT

        if self.timeRemaining <= 0 {
          self.asyncError = nil
          timer.invalidate()
        }
      })
    default:
      break
    }
  }

  func publishAlertError() {
    let error = PublishableError(
      .alertButton,
      description: "When the `Alert Error` button is pushed",
      reason: "You pressed the Alert Error Button"
    )
    errorPublisher.publish(error)
  }

  func publishAsynchronousError() {
    var error = PublishableError(
      .asyncError,
      description: "When the Async Error button is pushed",
      reason: "You pressed the Async Error Button"
    )
    error.context["async_loading_time"] = Int(asyncLoadingTime)

    isLoadingAsync = true
    DispatchQueue.main.asyncAfter(deadline: .now() + asyncLoadingTime) {
      self.isLoadingAsync = false
      self.errorPublisher.publish(error)
    }
  }

  func clearErrors() {
    timer?.invalidate()
    timer = nil

    alertError = nil
    asyncError = nil
  }
}
