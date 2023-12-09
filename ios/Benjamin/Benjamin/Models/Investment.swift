
import Foundation

struct Investment: Codable, Identifiable {
    // A structure that represents an investment
    var id: Int
    var name: String
    var symbol: String
    var change: Double
    var hold: Double // About of units holded by the user
    var price: Double
    var logo: String
}
