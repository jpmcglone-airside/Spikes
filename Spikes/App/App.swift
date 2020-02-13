import ErrorPublisher
import SwiftUI

class App: ObservableObject, ErrorSubscriber {
  let id = UUID()

  // Shared Services
  let errorPublisher: ErrorPublisher
  let errorLogger: ErrorLogger

  @Published var errors = [PublishableError]()

  // App entry
  @Published var tabSelection: Route = .mainMenu
  @Published var tabRoutes: [Route] = [
    .mainMenu,
    .about
  ]

  // MARK: - View Models
  // Main Menu
  @Lazy var mainMenuViewModel: MainMenuScreenModel

  // Other Main Screens
  @Lazy var errorPublisherViewModel: ErrorPublisherScreenModel
  @Lazy var allErrorsViewModel: AllErrorsScreenModel

  init() {
    defer {
      self.errorPublisher.subscribe(self)
      self.errorPublisher.subscribe(errorLogger)
    }

    errorLogger = ErrorLogger()

    let errorPublisher = ErrorPublisher()
    self.errorPublisher = errorPublisher

    _mainMenuViewModel = Lazy(MainMenuScreenModel())
    _errorPublisherViewModel = Lazy(ErrorPublisherScreenModel(errorPublisher: errorPublisher))
    _allErrorsViewModel = Lazy(AllErrorsScreenModel(errorPublisher: errorPublisher))

    print("Using ErrorPublisher \(ErrorPublisher.version)")
  }

  /// Clears the
  func clearMainViewModels() {
//    $errorPublisherViewModel.reset()
  }

  func receiveError(_ error: PublishableError) {
    errors.append(error)
  }
}
