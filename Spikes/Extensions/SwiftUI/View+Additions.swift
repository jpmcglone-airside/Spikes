import SwiftUI

public extension View {
  func eraseToAnyView() -> AnyView {
    return AnyView(self)
  }

  func withNavigation(_ showNavigation: Bool = true) -> some View {
    if showNavigation {
      return NavigationView {
        self
      }.eraseToAnyView()
    }
    return self.eraseToAnyView()
  }
}
