import ErrorPublisher
import SwiftUI

struct ErrorDetail: View {
  var error: PublishableError

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Image(systemName: "exclamationmark.circle").foregroundColor(.red)
        Text(error.key.value).foregroundColor(.red)
      }.padding(.bottom, 20)

      titleValue("Key", error.key.value)
      titleValue("Created at:", Utility.dateFormatter.string(from: error.createdAt))
      titleValue("Description", error.description ?? "N/A")
      titleValue("Reason", error.reason ?? "N/A")
      titleValue("Code", "\(error.code)")
      titleValue("Context", "\(error.context)")
      Spacer()

      VStack(alignment: .leading) {
        Text("ID:").fontWeight(.bold)
        Text(error.id.uuidString).font(.footnote).fontWeight(.light)
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
    .padding()
    .navigationBarTitle(error.key.value)
  }

  func titleValue(_ title: String, _ value: String) -> some View {
    VStack(alignment: .leading) {
      Text("\(title):").fontWeight(.bold)
      Text(value).fontWeight(.light)
    }
  }
}
