import ErrorPublisher
import SwiftUI

class AllErrorsScreenModel: ObservableObject, ErrorSubscriber {
  let id = UUID()
  let errorPublisher: ErrorPublisher

  @Published var errors = [PublishableError]()

  init(errorPublisher: ErrorPublisher) {
    self.errorPublisher = errorPublisher
    errorPublisher.subscribe(self)
  }

  deinit {
    errorPublisher.unsubscribe(self)
  }

  func receiveError(_ error: PublishableError) {
    errors.append(error)
  }
}
