import Foundation

struct Kelime: Identifiable, Codable {
    var id = UUID()
    var ingilizce: String
    var turkce: String
}
