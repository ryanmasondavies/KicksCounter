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

extension Array where Element == Kick {
    static func randomized() -> [Kick] {
        let daysAndMonths: [(month: Int, day: Int, kicks: Int)] = (0...10).map {
            (month: $0, day: $0, kicks: (0...100).randomElement()!)
        }
        guard !daysAndMonths.isEmpty else {
            return []
        }
        let calendar: Calendar = .current
        return daysAndMonths.map { month, day, kicks -> [Kick]? in
            guard let date = calendar.date(from: DateComponents(calendar: calendar, year: 2020, month: month, day: day, hour: 0, minute: 0, second: 0)) else {
                return nil
            }
            return Array(repeating: Kick(date: date, includesTime: false), count: kicks)
        }.compactMap { $0 }.flatMap { $0 }
    }
}
