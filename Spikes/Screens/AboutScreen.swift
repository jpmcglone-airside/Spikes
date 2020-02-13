import SwiftUI

struct AboutScreen: Screen {
  @EnvironmentObject var app: App

  var title = LocalizedStringKey("About")

  var body: some View {
    Text("About")
      .navigationBarTitle(title)
      .tabItem {
        Image(systemName: "star.fill")
        Text(title)
    }
  }
}
