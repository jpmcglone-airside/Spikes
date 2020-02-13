import ErrorPublisher
import SwiftUI

struct ErrorPublisherScreen: Screen {
  @EnvironmentObject var app: App

  @ObservedObject var model: ErrorPublisherScreenModel

  var title: LocalizedStringKey = "Error Manager Demo"

  var body: some View {
    VStack(alignment: .center, spacing: 5) {
      alertButton

      asyncButton
      Slider(value: $model.asyncLoadingTime, in: 1...10, step: 1)
        .padding().padding()
      Text("Async Loading Time: \(Int(model.asyncLoadingTime))s")
      Spacer()

      latestError
    }
    .alert(item: $model.alertError, content: errorAlert)
    .navigationBarTitle(title)
    .navigationBarItems(trailing: clearErrorsButton)
    .tabItem {
      Image(systemName: "star.fill")
      Text(title)
    }
  }

  var alertButton: some View {
    Button(action: model.publishAlertError) {
      Text("Alert Error")
        .foregroundColor(.white)
        .padding()
    }
    .background(Color.green)
  }

  var asyncButton: some View {
    if !model.isLoadingAsync && model.asyncError == nil {
      return
        Button(action: model.publishAsynchronousError) {
          Text("Async Error")
            .foregroundColor(.white)
            .padding()
        }
        .background(Color.blue)
        .eraseToAnyView()
        .transition(.slide)
    } else if model.isLoadingAsync {
      return
        Text("Loading...")
          .padding()
          .eraseToAnyView()
          .transition(.slide)
    } else {
      return
        HStack {
          Text(model.asyncError!.key.value)
          Image(systemName: "clock.fill")
          Text("(\(model.timeRemaining)s)").font(.footnote).padding(.leading, -5)
        }
        .foregroundColor(.red)
        .padding()
        .eraseToAnyView()
        .transition(.slide)
    }
  }

  var clearErrorsButton: some View {
    Button(action: model.clearErrors) {
      Text("Clear Errors")
    }
  }

  var latestError: some View {
    HStack {
      Text("Latest error:")
      Text(model.latestError?.key.value ?? "N/A")
        .foregroundColor(.red)
        .fontWeight(.bold)
    }
    .padding()
  }

  func errorAlert(error: PublishableError) -> Alert {
    Alert(
      title: Text("Error"),
      message: Text(error.reason ?? "")
    )
  }
}
