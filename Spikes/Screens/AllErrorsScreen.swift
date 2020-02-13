import ErrorPublisher
import SwiftUI

struct AllErrorsScreen: Screen {
  @EnvironmentObject var app: App
  @ObservedObject var model: AllErrorsScreenModel

  var title = LocalizedStringKey("All Errors")

  @State var error: PublishableError?

  var body: some View {
    List {
      ForEach(model.errors) { error in
        // TODO: Error information
        NavigationLink(destination: ErrorDetail(error: error)) {
          PublishableErrorRow(item: error)
        }
      }
    }
    .navigationBarItems(trailing:
      Button(action: {
        self.app.errorPublisher.publish(self.newFakeError())
      }) {
        Text("Fake Error")
      }
    )
    .navigationBarTitle(title)
    .tabItem {
      Image(systemName: "star.fill")
      Text(title)
    }
  }

  func newFakeError() -> PublishableError {
    return PublishableError(
      .fakeError,
      description: "A fake error in 'All Errors'",
      reason: "User touched the 'New Error' button",
      code: 0,
      context: ["status": "fake"],
      original: nil
    )
  }
}
