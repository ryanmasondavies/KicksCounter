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
    func filter(by timeframe: Timeframe, using calendar: Calendar) -> [Kick] {
        filter { kick in
            timeframe.hours.contains(calendar.component(.hour, from: kick.date))
        }
    }
}
