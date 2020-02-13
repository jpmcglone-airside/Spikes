import SwiftUI

struct ContentScreen: Screen {
  @EnvironmentObject var app: App

  var body: some View {
    TabView(selection: $app.tabSelection) {
      tabs
    }
  }

  private var tabs: some View {
    ForEach(app.tabRoutes, id: \.self) {
      $0.destination(app: self.app)
    }
  }
}

#if DEBUG
struct ContentScreen_Previews: PreviewProvider {
  static let app = App()

  static var previews: some View {
    ContentScreen().environmentObject(app)
  }
}
#endif
