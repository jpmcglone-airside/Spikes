import SwiftUI

struct RandomUserScreen: Screen {
  @EnvironmentObject var app: App

  var title = LocalizedStringKey("Random User")

  var body: some View {
    Text("Random User Demo")
      .navigationBarTitle(title)
      .tabItem {
        Image(systemName: "star.fill")
        Text(title)
    }
  }
}
