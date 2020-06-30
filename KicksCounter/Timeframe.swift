enum Timeframe: CaseIterable, CustomStringConvertible {
    case morning
    case midMorning
    case afternoon
    case earlyEvening
    case evening
    case lateEvening

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
