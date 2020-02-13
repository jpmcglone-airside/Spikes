import Foundation

extension Array where Element: Equatable {
  mutating func remove(object: Element) -> Element? {
    if let index = firstIndex(of: object) {
      return remove(at: index)
    }
    return nil
  }
}
