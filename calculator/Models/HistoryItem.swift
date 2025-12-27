import Foundation

struct HistoryItem: Identifiable, Codable {
    var id = UUID()
    var expression: String
    var result: String
    var timestamp: Date = Date()
}
