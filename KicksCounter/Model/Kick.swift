import Foundation

struct Kick: Codable {
    let date: Date

    init() {
        self.date = Date()
    }
}
