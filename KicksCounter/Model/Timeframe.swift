import Foundation

enum Timeframe: CaseIterable, CustomStringConvertible {
    case morning
    case midMorning
    case afternoon
    case earlyEvening
    case evening
    case lateEvening

    var hours: Range<Int> {
        switch self {
        case .morning:
            return 4..<8
        case .midMorning:
            return 8..<12
        case .afternoon:
            return 12..<16
        case .earlyEvening:
            return 16..<20
        case .evening:
            return 20..<24
        case .lateEvening:
            return 0..<4
        }
    }

    var description: String {
        switch self {
        case .morning:
            return "4am - 8am"
        case .midMorning:
            return "8am - 12pm"
        case .afternoon:
            return "12pm - 4pm"
        case .earlyEvening:
            return "4pm - 8pm"
        case .evening:
            return "8pm - 12am"
        case .lateEvening:
            return "12am - 4am"
        }
    }
}

extension Array where Element == Kick {
    func filter(by timeframe: Timeframe, on date: Date, using calendar: Calendar) -> [Kick] {
        filter(byDay: calendar.component(.day, from: date), using: calendar).filter { kick in
            timeframe.hours.contains(calendar.component(.hour, from: kick.date))
        }
    }

    func filter(byDay day: Int, using calendar: Calendar) -> [Kick] {
        filter { kick in
            calendar.component(.day, from: kick.date) == day
        }
    }

    private func kicks(on date: Date, using calendar: Calendar) -> [Kick] {
        filter(byDay: calendar.component(.day, from: date), using: calendar)
    }

    func average(for dates: [Date], using calendar: Calendar) -> Double {
        let totalKicks = dates.map { date -> Int in
            kicks(on: date, using: calendar).count
        }
        return Double(totalKicks.reduce(0, +)) / Double(dates.count)
    }
}

extension Calendar {
    func dates(forPreviousDays days: Int, from date: Date) -> [Date] {
        (-days..<0).compactMap { offset -> Date? in
            self.date(from: DateComponents(
                calendar: self,
                year: component(.year, from: date),
                month: component(.month, from: date),
                day: component(.day, from: date) + offset)
            )
        }
    }
}
