import SwiftUI

struct MenuRow: View {
  let item: MenuItem

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(item.title).bold()
        Text(item.description ?? "")
      }
    }
    .opacity(item.route != .none ? 1 : 0.5)
    .scaledToFill()
  }
}

#if DEBUG
struct MenuRow_Previews: PreviewProvider {
  static let item1 = MenuItem(
    title: "Menu Row Title",
    description: "Menu Row Description"
  )

  static let item2 = MenuItem(
    title: "Menu Row Title",
    description: "Menu Row Description",
    route: .errorPublisherDemo
  )

  static var previews: some View {
    List {
      MenuRow(item: item1)
      MenuRow(item: item2)
    }
  }
}
#endif
