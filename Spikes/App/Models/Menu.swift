import SwiftUI

struct Menu {
  var title: String
  var items: [MenuItem]

  var selection: MenuItem?

  init(title: String, items: [MenuItem]) {
    self.title = title
    self.items = items
  }
}
