import SwiftUI

class MainMenuScreenModel: ObservableObject {
  @Published var menu = Menu(
    title: "Main Menu",
    items: [
      MenuItem(
        title: "ErrorPublisher Demo",
        description: "Helps demo the Error Publisher",
        route: .errorPublisherDemo
      ),
      MenuItem(
        title: "Random User Demo",
        description: "Demo talking to www.randomuser.me API",
        route: .randomUser
      ),
      MenuItem(
        title: "This cell goes nowhere",
        description: "Just showing off the power of `MenuItem`"
      ),
      MenuItem(
        title: "All Errors",
        description: "A list of all errors",
        route: .allErrors
      )
  ])
}
