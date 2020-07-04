import Foundation

struct Kick: Codable {
    let date: Date
    var includesTime = true

    init() {
        self.date = Date()
    }

    init(date: Date, includesTime: Bool) {
        self.date = date
        self.includesTime = includesTime
    }
}
