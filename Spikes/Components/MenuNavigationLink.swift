import SwiftUI

struct MenuNavigationLink: View {
  @EnvironmentObject var app: App

  let item: MenuItem
  var canNavigate = true

  @Binding var selection: MenuItem?

  init(item: MenuItem, selection: Binding<MenuItem?>, canNavigate: Bool = true) {
    self.item = item
    self.canNavigate = canNavigate
    _selection = selection
  }

  var body: some View {
    if canNavigate && item.route != .none {
      return NavigationLink(destination: item.route.destination(app: self.app), tag: item, selection: $selection) {
        MenuRow(item: item)
      }.eraseToAnyView()
    } else {
      return MenuRow(item: item).eraseToAnyView()
    }
  }
}

#if DEBUG
struct MenuNavigationLink_Previews: PreviewProvider {
  static let item1 = MenuItem(
    title: "Menu Row Title",
    description: "Menu Row Description"
  )

  static let item2 = MenuItem(
    title: "Menu Row Title 2",
    description: "Menu Row Description 2",
    route: .errorPublisherDemo
  )

  static var previews: some View {
    List {
      MenuNavigationLink(item: item1, selection: .constant(nil))
      MenuNavigationLink(item: item2, selection: .constant(nil))
    }
  }
}
#endif
