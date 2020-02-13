import SwiftUI

struct NoneScreen: Screen {
  @EnvironmentObject var app: App

  var title = LocalizedStringKey("Page Not Found")

  var body: some View {
    Text("Not Found")
      .navigationBarTitle(title)
      .tabItem {
        Image(systemName: "exclamationmark.circle")
        Text(title)
    }
  }
}
