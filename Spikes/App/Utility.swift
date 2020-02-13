import Foundation

class Utility {
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss a zzz"
    return formatter
  }()

  static func formattedDate(_ date: Date) -> String {
    return dateFormatter.string(from: date)
  }
}
