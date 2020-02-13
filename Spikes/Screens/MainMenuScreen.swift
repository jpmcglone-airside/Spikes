import SwiftUI

struct MainMenuScreen: Screen {
  @EnvironmentObject var app: App

  @ObservedObject var model: MainMenuScreenModel

  @State var withNavigation = true
  var title = LocalizedStringKey("Main Menu")

  var body: some View {
    VStack {
      List {
        menu
      }
      button
    }
    .onAppear(perform: onAppear)
    .navigationBarTitle(title)
    .withNavigation(withNavigation)
    .tabItem {
      Image(systemName: "star.fill")
      Text(title)
    }
  }

  private var menu: some View {
    Group {
      ForEach(model.menu.items) { item in
        MenuNavigationLink(item: item, selection: self.$model.menu.selection)
      }
    }
  }

  private var button: some View {
    Button(action: {
      self.withNavigation.toggle()
    }) {
      Text("Navigation?")
    }
    .padding()
  }

  // TODO: (Thoughts) - It might be interesting to have an entire ViewModel *tree* in order
  // to restore the app to where we want to be. This would require a lot of coordination between Views and ViewModels
  // and some sort of "connector" or "coordinator" to accomplish.
  // This function is clearly not "state driven" -- but works for the sake of this app / demo
  private func onAppear() {
    app.clearMainViewModels()
  }
}
