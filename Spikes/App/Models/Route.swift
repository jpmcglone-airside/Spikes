import ErrorPublisher
import SwiftUI

enum Route {
  case none
  case mainMenu
  case errorPublisherDemo
  case allErrors
  case randomUser
  case about

  func destination(app: App) -> some View {
    var view: AnyView

    switch self {
    case .none:
      view = NoneScreen().eraseToAnyView()
    case .mainMenu:
      view = MainMenuScreen(model: app.mainMenuViewModel).eraseToAnyView()
    case .errorPublisherDemo:
      view = ErrorPublisherScreen(model: app.errorPublisherViewModel).eraseToAnyView()
    case .allErrors:
      view = AllErrorsScreen(model: app.allErrorsViewModel).eraseToAnyView()
    case .randomUser:
      view = RandomUserScreen().eraseToAnyView()
    case .about:
      view = AboutScreen().eraseToAnyView()
    }

    // Automatically tagging the view with 'self' has many benefits around tabs, lists, and more
    return view.tag(self)
  }
}
