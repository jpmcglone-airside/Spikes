import SwiftUI

struct MenuItem: Identifiable, Hashable {
  var id: Route { self.route }

  let title: LocalizedStringKey
  let description: LocalizedStringKey?
  let systemImageName: String?

  let route: Route

  init(title: LocalizedStringKey, description: LocalizedStringKey? = nil, route: Route = .none) {
    self.title = title
    self.description = description
    self.route = route
    self.systemImageName = nil
  }

  static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
    return lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    id.hash(into: &hasher)
  }
}
