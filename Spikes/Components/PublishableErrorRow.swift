import ErrorPublisher
import SwiftUI

struct PublishableErrorRow: View {
  let item: PublishableError

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(systemName: "exclamationmark.circle").foregroundColor(.red)
        Text(item.key.value).bold().foregroundColor(.red)
      }
      Text(Utility.formattedDate(item.createdAt))
        .font(.system(size: 12))
        .italic()
        .opacity(0.5)
    }
    .scaledToFill()
  }
}
